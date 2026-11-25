// error: branches have mismatched types: Pair vs i64
struct Pair { x: i64, y: i64 }
fn choose<F>(flag: bool) {
    let value = if flag { F() } else { 42 };
    print(value);
}
fn main() {
    choose(false) { defer { abort("stop"); } Pair { x: 1, y: 2 } };
}
