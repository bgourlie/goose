// error: while saved is still used
fn invoke<F>() -> i64 { F() }
fn main() {
    var nodes: i64[>..] = [42];
    let saved .= nodes[0];
    fn value() -> i64 { saved }
    {
        let value = 17;
        nodes.clear();
        assert(value == 17);
    }
    assert(invoke(value) == 42);
}
