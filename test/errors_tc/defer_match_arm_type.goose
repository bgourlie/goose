// error: branches have mismatched types
struct Pair { x: i64, y: i64 }
fn run(index: i64) {
    let value = match index {
        0 => { defer { abort("stop"); } Pair { x: 1, y: 2 } },
        _ => 42,
    };
    print(value);
}
fn main() { run(1); }
