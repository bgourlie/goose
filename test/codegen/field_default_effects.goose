var count: i64 = 0;
let seed: i64 = 10;
fn tick() -> i64 { count++; count }
struct S<T> { first: i64 = tick(), middle: i64, last: i64 = seed }
struct D { n: i64 = tick() }
enum E { One { n: i64 = tick() }, Two }

fn finish() -> i64 { return 42 from make; }
struct Exits { n: i64 = finish() }
fn empty_run(pool: Exits[>..]&) -> Exits[:] { pool[0..0] }
fn make(reallocate: bool) -> i64 {
    const ONE: i64 = 1;
    reusable[] var pool: Exits[>..] = [];
    if reallocate { pool.realloc_slice(empty_run(pool), ONE); }
    else { pool.alloc_slice(ONE); }
}

fn main() {
    assert(make(true) == 42 && make(false) == 42);
    let seed = 99;
    fn tick() -> i64 { 999 }
    let a = S<u8> { middle: ::tick() };
    let b = S<u8> { middle: ::tick() };
    print(a, " ", b);
    let ds = default<D[2]>();
    let e = default<E>();
    print(ds, " ", e);
    reusable[] var pool: D[>..] = [];
    let run = pool.alloc_slice(2);
    print(run, " ", count);
    const ONE: u8 = 1;
    let empty = pool.alloc_slice(ONE - 1);
    let one = pool.realloc_slice(run, ONE);
    assert(empty.len == 0 && one.len == 1 && count == 9);
    let grown = pool.realloc_slice(one, ONE + 1);
    assert(grown[1].n == 10 && count == 10);
    // This default can only run inside make. A zero count skips it here.
    reusable[] var skips: Exits[>..] = [];
    let skipped = skips.alloc_slice(ONE - 1);
    assert(skipped.len == 0);
    reusable[] var kept: Exits[>..] = [Exits { n: 7 }, Exits { n: 8 }];
    let first = kept.realloc_slice(kept[^2..], 1);
    assert(first.len == 1 && first[0].n == 7);
}
