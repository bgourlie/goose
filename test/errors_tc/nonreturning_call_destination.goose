// error: expected a value of type i64, got Pair
struct Pair { x: i64, y: i64 }
fn stopped() -> Pair { abort("stop"); }
fn main() { let value: i64 = stopped(); }
