// error: function make can fall off the end without returning value(s)
fn finish() -> i64 { return 42 from make; }
struct Item { n: i64 = finish() }

fn make() -> i64 {
    let n = 1;
    let alias .= n;
    alias = 0;
    reusable[] var pool: Item[>..] = [];
    pool.alloc_slice(n);
}

fn main() { print(make()); }
