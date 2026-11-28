// error: function make can fall off the end without returning value(s)
fn finish() -> i64 { return 42 from make; }
struct Item { n: i64 = finish() }

fn make(pool: Item[>..]&, run: Item[:]) -> i64 {
    const ONE: i64 = 1;
    pool.realloc_slice(run, ONE);
}

fn main() {
    reusable[] var pool: Item[>..] = [Item { n: 0 }];
    print(make(pool, pool[0..1]));
}
