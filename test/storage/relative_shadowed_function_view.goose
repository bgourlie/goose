fn run<F>() { F(); }
fn take<F>(n: i64) { F(n); }

fn main() {
    var nodes: i64[>..] = [42];
    let saved .= nodes[0];
    fn value() -> i64 { saved }
    assert(value() == 42);
    {
        let value = 17;
        nodes.clear();
        run() { run() { assert(value == 17); }; };
    }
    take(23) { value => run() { assert(value == 23); }; };
    print("ok");
}
