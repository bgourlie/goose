// error: defer body writes through an alias to bag
struct Bag { count: i64, items: i64[>..] }
fn choose(flag: bool, a: i64&, b: i64&) -> i64& { if flag { a } else { b } }
fn build(header: bool, tail: bool) -> Bag {
    var bag = Bag { count: 7, items: [42] };
    var other = 0;
    let safe: i64& = if header { bag.count } else { other };
    let target .= choose(tail, bag.items[0], safe);
    defer { target++; }
    return bag;
}
fn main() { print(build(false, true)); }
