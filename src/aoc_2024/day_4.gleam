import gleam/dict.{type Dict}
import gleam/list
import gleam/string

pub fn parse(input: String) -> Dict(#(Int, Int), String) {
  let map = dict.new()
  use map, row, y <- list.index_fold(string.split(input, "\n"), map)
  use map, letter, x <- list.index_fold(string.split(row, ""), map)
  dict.insert(map, #(x, y), letter)
}

fn v_add(v1: #(Int, Int), v2: #(Int, Int)) -> #(Int, Int) {
  #(v1.0 + v2.0, v1.1 + v2.1)
}

fn get_word(map, pos: #(Int, Int), dir: #(Int, Int), length: Int, word: String) {
  case length {
    0 -> word
    _ -> {
      case dict.get(map, pos) {
        Ok(letter) ->
          get_word(map, v_add(pos, dir), dir, length - 1, word <> letter)
        Error(_) -> word
      }
    }
  }
}

pub fn pt_1(map: Dict(#(Int, Int), String)) {
  let directions = [
    #(0, 1),
    #(1, 1),
    #(1, 0),
    #(1, -1),
    #(0, -1),
    #(-1, -1),
    #(-1, 0),
    #(-1, 1),
  ]

  use countd, start, _ <- dict.fold(map, 0)
  use countl, direction <- list.fold(directions, countd)
  case get_word(map, start, direction, 4, "") {
    "XMAS" -> countl + 1
    _ -> countl
  }
}

pub fn pt_2(map: Dict(#(Int, Int), String)) {
  use count, start, _ <- dict.fold(map, 0)
  case
    get_word(map, start, #(1, 1), 3, ""),
    get_word(map, start |> v_add(#(2, 0)), #(-1, 1), 3, "")
  {
    "MAS", "MAS" | "MAS", "SAM" | "SAM", "MAS" | "SAM", "SAM" -> count + 1
    _, _ -> count
  }
}
