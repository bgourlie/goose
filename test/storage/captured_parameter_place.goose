struct Bag { tag: i64, xs: i64[>..<] }
struct Header { tag: i64, values: i64[1] }
struct State { header: Header, bag: Bag }
enum Route { Direct, Nested }

fn before_rebuild(route: Route, stop: bool) {
    var state = State { header: Header { tag: 7, values: [11] }, bag: Bag { tag: 9, xs: [1] } };
    var tag .= state.bag.tag;
    var values: i64[:] = state.header.values[..];
    fn bind(to: i64&) { tag .= to; }
    fn select(r: Route.Direct, to: Header&) { bind(to.tag); }
    fn select(r: Route.Nested, to: Header&) {
        fn leave(inner: i64&) { tag .= inner; return from select; }
        leave(to.tag);
    }
    fn bind_view(to: i64[:]) { values = to; }

    bind(state.bag.tag);
    select(route, state.header);
    bind_view(state.header.values[..]);
    defer { assert(tag == 7 && values[0] == 11); }
    state.bag = Bag { tag: 8, xs: [2, if stop { return; } else { 3 }] };
}

fn inside_defer(stop: bool) {
    var state = State { header: Header { tag: 7, values: [11] }, bag: Bag { tag: 9, xs: [1] } };
    var tag .= state.bag.tag;
    fn observe(to: i64&) {
        tag .= to;
        assert(tag == 7);
    }
    defer observe(state.header.tag);
    state.bag = Bag { tag: 8, xs: [2, if stop { return; } else { 3 }] };
}

fn recursive_bind(stop: bool) {
    var state = State { header: Header { tag: 7, values: [11] }, bag: Bag { tag: 9, xs: [1] } };
    var tag .= state.bag.tag;
    recursive fn bind(to: i64&, depth: i64) {
        tag .= to;
        if depth > 0 { bind(to, depth - 1); }
    }
    bind(state.header.tag, 2);
    // A recursive call that preserves a known capture need not lose its field.
    recursive fn keep(depth: i64) {
        if depth > 0 { tag .= state.header.tag; keep(depth - 1); }
    }
    keep(2);
    defer { assert(tag == 7); }
    state.bag = Bag { tag: 8, xs: [2, if stop { return; } else { 3 }] };
}

fn main() {
    for stop in [false, true] {
        before_rebuild(Route.Direct, stop);
        before_rebuild(Route.Nested, stop);
        inside_defer(stop);
        recursive_bind(stop);
    }
    print("ok");
}
