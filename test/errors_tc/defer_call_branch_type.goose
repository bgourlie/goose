// error: branches have mismatched types: Pair vs i64
struct Pair { x: i64, y: i64 }
fn stopped() -> Pair {
    defer { abort("stop"); }
    return Pair { x: 1, y: 2 };
}
fn choose(flag: bool) {
    let value = if flag { stopped() } else { 42 };
    print(value);
}
fn main() { choose(false); }
