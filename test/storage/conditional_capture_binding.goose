struct Header { tag: i64, values: i64[1] }
struct Bag { tag: i64, xs: i64[>..<] }
struct State { header: Header, bag: Bag }

fn after_call(change: bool, stop: bool) {
    var state = State { header: Header { tag: 7, values: [11] }, bag: Bag { tag: 9, xs: [1] } };
    var tag .= state.header.tag;
    var values: i64[:] = state.header.values[..];
    fn bind(to: i64&, view: i64[:]) {
        if change { tag .= to; values = view; }
        let alias .= tag;
        tag .= alias;
    }
    fn relay(to: Header&) { bind(to.tag, to.values[..]); }
    relay(state.header);
    defer { assert(tag == 7 && values[0] == 11); }
    state.bag = Bag { tag: 8, xs: [2, if stop { return; } else { 3 }] };
}

fn inside_call(change: bool, stop: bool) {
    var state = State { header: Header { tag: 7, values: [11] }, bag: Bag { tag: 9, xs: [1] } };
    var header .= state.header;
    fn observe(to: Header&) {
        if change { header .= to; }
        assert(header.tag == 7);
    }
    defer observe(state.header);
    state.bag = Bag { tag: 8, xs: [2, if stop { return; } else { 3 }] };
}

fn across_returns(change: bool, stop: bool) {
    var state = State { header: Header { tag: 7, values: [11] }, bag: Bag { tag: 9, xs: [1] } };
    var tag .= state.header.tag;
    fn choose(first: i64&, second: i64&) {
        fn leave() { tag .= first; return from choose; }
        if change { leave(); }
        tag .= second;
    }
    choose(state.header.tag, state.header.tag);
    defer { assert(tag == 7); }
    state.bag = Bag { tag: 8, xs: [2, if stop { return; } else { 3 }] };
}

fn across_recursion(change: bool, stop: bool) {
    var state = State { header: Header { tag: 7, values: [11] }, bag: Bag { tag: 9, xs: [1] } };
    var tag .= state.header.tag;
    recursive fn bind(to: i64&, depth: i64) {
        if change { tag .= to; }
        if depth > 0 { bind(to, depth - 1); }
    }
    bind(state.header.tag, 2);
    defer { assert(tag == 7); }
    state.bag = Bag { tag: 8, xs: [2, if stop { return; } else { 3 }] };
}

fn many_formals(choice: i64, stop: bool) {
    var state = State { header: Header { tag: 7, values: [11] }, bag: Bag { tag: 9, xs: [1] } };
    var tag .= state.bag.tag;
    fn choose(a: i64&, b: i64&, c: i64&, d: i64&, e: i64&) {
        if choice == 0 { tag .= a; }
        else if choice == 1 { tag .= b; }
        else if choice == 2 { tag .= c; }
        else if choice == 3 { tag .= d; }
        else { tag .= e; }
    }
    let safe .= state.header.tag;
    choose(safe, safe, safe, safe, safe);
    defer { assert(tag == 7); }
    state.bag = Bag { tag: 8, xs: [2, if stop { return; } else { 3 }] };
}

fn main() {
    for change in [false, true] {
        for stop in [false, true] {
            after_call(change, stop);
            inside_call(change, stop);
            across_returns(change, stop);
            across_recursion(change, stop);
        }
    }
    for i in 0..5 { many_formals(i, true); }
    print("ok");
}
