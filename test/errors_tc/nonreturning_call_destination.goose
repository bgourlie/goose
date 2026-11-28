// xfail: accepts-invalid
// error: expected a value of type i64, got Pair
// The call has the declared result type Pair even though its body aborts (§7.3).
struct Pair { x: i64, y: i64 }
fn stopped() -> Pair { abort("stop"); }
fn main() { let value: i64 = stopped(); }
