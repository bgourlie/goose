// error: defer body writes through an alias to out
struct Item { n: i64, other: i64, next: Item&<u32>? }
fn stop() -> i64 { abort("stop"); }
fn change(item: Item&) -> i64 { item.n = 2; return 1; }
fn build(flag: bool) -> Item[>..] {
    var out: Item[>..] = [Item { n: 0, other: 0 }];
    let alias .= out;
    defer { if flag { alias.append([Item { n: change(alias[0]), other: stop() }; 2]); } }
    return out;
}
fn main() { print(build(false).len); }
