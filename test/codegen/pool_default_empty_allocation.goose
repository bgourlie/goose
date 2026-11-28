// xfail: typecheck call to finish requires an enclosing call of make (it does `return ... from make`)
// Only newly allocated elements evaluate the field default that returns from make (§5.4).
fn finish() -> i64 { return 42 from make; }
struct Item { n: i64 = finish() }
fn make() -> i64 {
    reusable[] var pool: Item[>..] = [];
    pool.alloc_slice(1);
}
fn main() {
    assert(make() == 42);
    reusable[] var pool: Item[>..] = [];
    let empty = pool.alloc_slice(0);
    assert(empty.len == 0);
}
