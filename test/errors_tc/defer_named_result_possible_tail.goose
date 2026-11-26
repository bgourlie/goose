// error: defer body writes through an alias to bag
struct Bag { count: i64, items: i64[>..] }
fn choose(flag: bool, a: i64&, b: i64&) -> i64& { if flag { a } else { b } }
fn build(flag: bool) -> Bag {
    var bag = Bag { count: 7, items: [42] };
    let alias .= choose(flag, bag.count, bag.items[0]);
    defer { alias++; }
    return bag;
}
fn main() { print(build(true)); }
