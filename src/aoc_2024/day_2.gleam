import gleam/function
import gleam/int
import gleam/io
import gleam/list
import gleam/string

pub fn parse(input: String) -> List(List(Int)) {
  input
  |> string.split("\n")
  |> list.map(fn(line) {
    line
    |> string.split(" ")
    |> list.map(fn(n) {
      let assert Ok(number) = int.parse(n)
      number
    })
  })
}

pub fn pt_1(input: List(List(Int))) {
  list.map(input, fn(level) {
    let diffs =
      level
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
  })
  |> list.filter(function.identity)
  |> list.length
}

pub fn pt_2(input: List(List(Int))) {
  todo as "not implemented yet"
}
