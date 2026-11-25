// error: defer body writes through an alias to out
struct Item { value: i64, next: Item&<u32>? }
fn stop() -> i64 { abort("stop"); }
fn build(flag: bool) -> Item[>..] {
    var out: Item[>..] = [];
    let alias .= out;
    defer { if flag { alias.append([Item { value: 1 }, Item { value: stop() }]); } }
    return out;
}
fn main() { print(build(false)); }
