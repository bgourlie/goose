fn run<F>() { F(); }
fn take<F>(n: i64) { F(n); }
fn expect(n: i64) { assert(n == 17); }
enum Token { Num { n: i64 } }
fn expect(t: Token.Num) { expect(t.n); }

fn later_bindings() {
    var nodes: i64[>..] = [42];
    let saved .= nodes[0];
    fn value() -> i64 { saved }
    fn it() -> i64 { saved }
    assert(value() == it());
    nodes.clear();
    {
        let value = 17;
        expect(value);
    }
    for value in [17, 17] { expect(value); }
    for value in block { nodes.clear(); [17] } { expect(value); }
    let token: Token = Token.Num { n: 17 };
    match block { nodes.clear(); token } { Num value => expect(value) }
    take(17) { assert(it == 17); };
    take(17) { expect(it); };
    take(17) { it.expect(); };
    take(17) { assert(str(it) == "17"); };
    let value = 17;
    expect(value);
}

fn captured_binding() {
    var nodes: i64[>..] = [42];
    let saved .= nodes[0];
    assert(saved == 42);
    {
        let saved = 17;
        fn value() -> i64 { saved }
        nodes.clear();
        expect(value());
    }
}

fn main() {
    later_bindings();
    captured_binding();
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
