// xfail: typecheck cannot clear nodes while saved is still used: it may hold a reference or slice into it (§5.1)
// The nested function captures the inner integer. The outer reference has had its last use (§5.1).
fn captured_binding() {
    var nodes: i64[>..] = [42];
    let saved .= nodes[0];
    assert(saved == 42);
    {
        let saved = 17;
        fn value() -> i64 { saved }
        nodes.clear();
        assert(value() == 17);
    }
}

fn main() { captured_binding(); }
