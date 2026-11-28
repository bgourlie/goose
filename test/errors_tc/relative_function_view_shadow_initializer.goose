// xfail: accepts-invalid
// error: while saved is still used
// The initializer resolves value to the function. Its new binding begins after the initializer.
fn invoke<F>() -> i64 { F() }

fn main() {
    var nodes: i64[>..] = [42];
    let saved .= nodes[0];
    fn value() -> i64 { saved }
    nodes.clear();
    let value = invoke(value);
    print(value);
}
