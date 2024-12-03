import gleam/int
import gleam/option.{type Option, Some}

pub fn parse_int(number: String) -> Int {
  let assert Ok(n) = int.parse(number)
  n
}

pub fn get_some(option: Option(a)) -> a {
  let assert Some(v) = option
  v
}
