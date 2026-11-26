// error: defer body writes through an alias to out
enum Item { A { value: i64 }, B }
fn stop() -> Item.A { abort("stop"); }
fn partial() -> Item.. { stop() }
fn build(flag: bool) -> Item..[>..] {
    var out: Item..[>..] = [];
    let alias .= out;
    defer { if flag { alias.push(partial()); } }
    return out;
}
fn main() { print(build(false).len); }
