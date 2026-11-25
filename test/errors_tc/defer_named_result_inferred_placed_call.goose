// error: defer body writes through an alias to out
struct Item { value: i64, other: i64, next: Item&<u32>? }
fn stop() -> i64 { abort("stop"); }
fn partial() { return Item { value: 1, other: stop() }, false; }
fn forward() { return partial(); }
fn build() -> Item[] {
    var out: Item[] = [Item { value: 42, other: 0 }];
    let first .= out[0];
    defer { first = forward(); }
    return out;
}
fn main() { print(build()); }
