// error: expected a value of type i64, got bool
fn compute() -> i64 {
    for i in 0 { return true; }
    5
}
fn main() { print(compute()); }
