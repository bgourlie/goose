// error: defer body writes through an alias to out
struct Item { value: i64, other: i64, next: Item&<u32>? }
fn stop() -> i64 { abort("stop"); }
fn build(flag: bool) -> Item[] {
    var out: Item[] = [Item { value: 0, other: 0 }];
    let first .= out[0];
    defer { if flag { first = Item { value: 41, other: stop() }; } }
    return out;
}
fn main() { print(build(false)); }
