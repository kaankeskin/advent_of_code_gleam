import gleam/int

pub fn parse_int(number: String) -> Int {
  let assert Ok(n) = int.parse(number)
  n
}
