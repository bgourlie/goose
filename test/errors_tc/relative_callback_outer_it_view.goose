// error: while saved is still used
fn run<F>() { F(); }

fn main() {
    var nodes: i64[>..] = [42];
    let saved .= nodes[0];
    fn it() -> i64 { saved }
    nodes.clear();
    run() { assert(it() == 42); };
}
