// error: defer body writes through an alias to out
struct Item { next: Item&<u32>?, n: i64 }
fn stop() -> i64 { abort("stop"); }
fn build(flag: bool) -> Item[>..] {
    var out: Item[>..] = [];
    let alias .= out;
    defer { if flag { alias.push(Item { n: stop() }); } }
    return out;
}
fn main() { print(build(false).len); }
