fn main() {
    var nodes: i64[>..] = [42];
    let saved .= nodes[0];
    fn value() -> i64 { saved }
    assert(value() == 42);
    {
        let value = 17;
        nodes.clear();
        assert(value == 17);
    }
    print("ok");
}
