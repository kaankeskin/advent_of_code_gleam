import gleam/int
import gleam/list
import gleam/regexp.{type Match}
import utils

pub fn pt_1(input: String) {
  let assert Ok(re) = regexp.from_string("mul\\((\\d{1,3}),(\\d{1,3})\\)")
  let matches = regexp.scan(re, input)
  matches
  |> list.map(fn(match) {
    match.submatches
    |> list.map(utils.get_some)
    |> list.map(utils.parse_int)
    |> list.fold(1, fn(acc, curr) { acc * curr })
  })
  |> int.sum
}

pub type Operation {
  Mul(Int, Int)
  Dont
  Do
}

fn match_to_op(match: Match) -> Operation {
  case match.content {
    "do()" -> Do
    "don't()" -> Dont
    _ -> {
      let mul = case
        match.submatches
        |> list.map(fn(sm) { sm |> utils.get_some |> utils.parse_int })
      {
        [a, b] -> Mul(a, b)
        _ -> Mul(1, 1)
      }
      mul
    }
  }
}

fn mul_to_int(op: Operation) -> Int {
  let assert Mul(a, b) = op
  a * b
}

fn filter_donts(ops: List(Operation), within: Bool) -> List(Operation) {
  case ops {
    [] -> []
    [head, ..rest] -> {
      case head {
        Do -> filter_donts(rest, True)
        Dont -> filter_donts(rest, False)
        Mul(_, _) ->
          case within {
            True -> [head, ..filter_donts(rest, True)]
            False -> filter_donts(rest, False)
          }
      }
    }
  }
}

// [Mul(2, 4), Mul(8, 5), Mul(2, 4) Do, Mul(8, 5)]
pub fn pt_2(input: String) {
  let assert Ok(re) =
    regexp.from_string("mul\\((\\d{1,3}),(\\d{1,3})\\)|don't\\(\\)|do\\(\\)")
  regexp.scan(re, input)
  |> list.map(match_to_op)
  |> filter_donts(True)
  |> list.map(mul_to_int)
  |> int.sum
}
