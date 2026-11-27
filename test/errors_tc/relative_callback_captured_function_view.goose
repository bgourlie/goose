// error: while saved is still used
fn take<F>(n: i64) { F(n); }

fn main() {
    var nodes: i64[>..] = [42];
    let saved .= nodes[0];
    fn read() -> i64 { saved }
    nodes.clear();
    take(17) { saved => assert(read() == 42 && saved == 17); };
}
