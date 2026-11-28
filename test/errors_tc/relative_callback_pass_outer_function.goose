// xfail: accepts-invalid
// error: while saved is still used
// The callback passes the outer function, which still reads saved after the clear (§5.1).
fn run<F>() { F(); }
fn expect(n: i64) { assert(n == 17); }
fn expect<F>(n: i64 = 42) { assert(F() == n); }

fn main() {
    var nodes: i64[>..] = [42];
    let saved .= nodes[0];
    fn it() -> i64 { saved }
    nodes.clear();
    run() { expect(it); };
}
