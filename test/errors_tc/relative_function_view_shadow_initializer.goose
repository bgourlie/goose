// error: while saved is still used
fn invoke<F>() -> i64 { F() }

fn main() {
    var nodes: i64[>..] = [42];
    let saved .= nodes[0];
    fn value() -> i64 { saved }
    nodes.clear();
    let value = invoke(value);
    print(value);
}
