// error: reordering may cross a side effect, runtime check, or nonlocal exit
struct Pair { a: i64, b: i64 }

fn plus_one(n: i64) -> i64 { n + 1 }
fn make(x: i64) -> Pair { Pair { b: plus_one(x), a: x } }
fn main() { print(make(1)); }
