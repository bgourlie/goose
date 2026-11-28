// xfail: typecheck cannot assign to let y (§4.4)
// Exactly one case runs and initializes y; the argument that initializes x runs once (§8.2).
enum Choice { A, B }
fn test_assignment(c: Choice, want: i64) {
    let x: i64;
    let y: i64;
    fn handle(c: Choice.A, n: i64) { y = n + 1; }
    fn handle(c: Choice.B, n: i64) { y = n + 2; }
    handle(block { x = 41; c }, x);
    assert(x == 41 && y == want);
}
fn main() {
    test_assignment(Choice.A {}, 42);
    test_assignment(Choice.B {}, 43);
}
