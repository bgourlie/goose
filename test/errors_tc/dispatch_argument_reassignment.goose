// error: cannot assign to let x
enum Action { A, B }
fn handle(a: Action.A, n: i64) {}
fn handle(b: Action.B, n: i64) {}
fn main() {
    let tag: Action = Action.A;
    let x: i64;
    handle(block { x = 41; tag }, block { x = 42; x });
}
