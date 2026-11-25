// error: variable x may be used before it is assigned
enum Action { A, B }
fn run(tag: Action) {
    let x: i64;
    fn handle(a: Action.A) { x = 41; }
    fn handle(b: Action.B) {}
    handle(tag);
    print(x);
}
fn main() { run(Action.B); }
