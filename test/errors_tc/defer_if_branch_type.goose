// error: branches have mismatched types
struct Pair { x: i64, y: i64 }
fn run(stop: bool) {
    let value = if stop {
        defer { abort("stop"); }
        Pair { x: 1, y: 2 }
    } else { 42 };
    print(value);
}
fn main() { run(false); }
