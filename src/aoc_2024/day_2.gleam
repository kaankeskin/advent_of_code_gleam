import gleam/bool
import gleam/int
import gleam/list
import gleam/string
import utils

pub fn parse(input: String) -> List(List(Int)) {
  input
  |> string.split("\n")
  |> list.map(fn(line) {
    line
    |> string.split(" ")
    |> list.map(utils.parse_int)
  })
}

fn is_safe(report: List(Int)) -> Bool {
  let diffs =
    report
    |> list.window_by_2
    |> list.map(fn(w) {
      let #(a, b) = w
      a - b
    })
  let is_all_increasing = diffs |> list.all(fn(x) { x < 0 })
  let is_all_decreasing = diffs |> list.all(fn(x) { x > 0 })
  let is_safe_diff =
    diffs
    |> list.map(int.absolute_value)
    |> list.all(fn(x) { x >= 1 && x <= 3 })
  { is_all_increasing || is_all_decreasing } && is_safe_diff
}

fn is_tolerated_safe(report: List(Int)) -> Bool {
  use <- bool.guard(is_safe(report), True)

  report
  |> list.combinations(list.length(report) - 1)
  |> list.any(fn(eliminated_report) { is_safe(eliminated_report) })
}

pub fn pt_1(input: List(List(Int))) {
  list.count(input, is_safe)
}

pub fn pt_2(input: List(List(Int))) {
  list.count(input, is_tolerated_safe)
}
