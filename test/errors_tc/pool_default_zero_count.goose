// xfail: accepts-invalid
// error: function make can fall off the end without returning value(s)
// A zero-length allocation evaluates no defaults, so make can fall through (§5.4).
fn finish() -> i64 { return 42 from make; }
struct Item { n: i64 = finish() }

fn make() -> i64 {
    const ONE: u8 = 1;
    reusable[] var pool: Item[>..] = [];
    pool.alloc_slice(ONE - 1);
}

fn main() { print(make()); }
