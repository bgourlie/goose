// error: defer body writes through an alias to bag
struct Bag { count: i64, items: i64[>..] }
fn increment(n: i64&) { n++; }
fn update(b: Bag&) {
    increment(b.count);
    increment(b.items[0]);
}
fn build() -> Bag {
    var bag = Bag { count: 7, items: [42] };
    let alias .= bag;
    defer update(alias);
    return bag;
}
fn main() { print(build()); }
