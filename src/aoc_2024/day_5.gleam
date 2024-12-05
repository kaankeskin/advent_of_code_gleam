import gleam/bool
import gleam/dict.{type Dict}
import gleam/function
import gleam/int
import gleam/list
import gleam/option.{None, Some}
import gleam/order
import gleam/result
import gleam/string
import utils

pub type Day5Input {
  Day5Input(rules: Dict(Int, List(Int)), updates: List(List(Int)))
}

pub fn parse(input: String) -> Day5Input {
  let assert [rule_lines, update_lines] = string.split(input, "\n\n")

  let rules =
    rule_lines
    |> string.split("\n")
    |> list.map(fn(rule_line) {
      let assert [fst, snd] =
        rule_line
        |> string.split("|")
        |> list.map(utils.parse_int)
      #(fst, snd)
    })
    |> list.fold(dict.new(), fn(acc, curr) {
      dict.upsert(acc, curr.0, fn(x) {
        case x {
          None -> [curr.1]
          Some(vals) -> [curr.1, ..vals]
        }
      })
    })

  let updates =
    update_lines
    |> string.split("\n")
    |> list.map(fn(update_line) {
      update_line
      |> string.split(",")
      |> list.map(utils.parse_int)
    })

  Day5Input(rules, updates)
}

fn get_middle(list: List(a)) -> a {
  let length = list.length(list)
  let middle_index = length / 2 + 1
  let assert Ok(middle_element) =
    list.drop(list, middle_index - 1) |> list.first
  middle_element
}

pub fn pt_1(input: Day5Input) -> Int {
  input.updates
  |> list.filter(fn(update) {
    update
    |> list.combination_pairs
    |> list.map(fn(c) {
      case dict.get(input.rules, c.0) {
        Ok(values) -> {
          list.contains(values, c.1)
        }
        Error(_) -> False
      }
    })
    |> list.all(function.identity)
  })
  |> list.map(get_middle)
  |> int.sum
}

pub fn pt_2(input: Day5Input) -> Int {
  input.updates
  |> list.filter(fn(update) {
    update
    |> list.combination_pairs
    |> list.map(fn(c) {
      case dict.get(input.rules, c.0) {
        Ok(values) -> {
          list.contains(values, c.1)
        }
        Error(_) -> False
      }
    })
    |> list.map(bool.negate)
    |> list.any(function.identity)
  })
  |> list.map(fn(update) {
    list.sort(update, fn(a, b) {
      let a_list = dict.get(input.rules, a) |> result.unwrap([])
      let b_list = dict.get(input.rules, b) |> result.unwrap([])

      case list.contains(a_list, b), list.contains(b_list, a) {
        True, _ -> order.Lt
        False, True -> order.Gt
        _, _ -> order.Eq
      }
    })
  })
  |> list.map(get_middle)
  |> int.sum
}
