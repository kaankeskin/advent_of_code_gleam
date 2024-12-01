import gleam/int
import gleam/list
import gleam/string
import tote/bag

pub type Day1Input {
  Day1Input(left_list: List(Int), right_list: List(Int))
}

pub fn parse(input: String) -> Day1Input {
  input
  |> string.split("\n")
  |> list.fold(Day1Input([], []), fn(acc, line) {
    case string.split(line, "   ") {
      [a, b] -> {
        let assert Ok(left) = int.parse(a)
        let assert Ok(right) = int.parse(b)
        Day1Input([left, ..acc.left_list], [right, ..acc.right_list])
      }
      _ -> acc
    }
  })
}

pub fn pt_1(input: Day1Input) -> Int {
  let Day1Input(left_list, right_list) = input

  list.zip(
    list.sort(left_list, int.compare),
    list.sort(right_list, int.compare),
  )
  |> list.fold(0, fn(acc, lists) { acc + int.absolute_value(lists.0 - lists.1) })
}

pub fn pt_2(input: Day1Input) -> Int {
  let Day1Input(left_list, right_list) = input

  let right_bag = bag.from_list(right_list)
  list.fold(left_list, 0, fn(acc, curr) {
    acc + curr * bag.copies(right_bag, curr)
  })
}
