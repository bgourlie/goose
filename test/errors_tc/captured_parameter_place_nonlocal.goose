// error: a defer on this exit can observe state.bag partially rebuilt
struct Bag { tag: i64, xs: i64[>..<] }
struct State { tag: i64, bag: Bag }

fn replace(stop: bool) {
    var state = State { tag: 7, bag: Bag { tag: 9, xs: [1] } };
    var tag .= state.tag;
    fn phase(to: i64&) {
        fn leave(inner: i64&) { tag .= inner; return from phase; }
        if stop { leave(to); }
        tag .= state.tag;
    }
    phase(state.bag.tag);
    defer { print(tag); }
    state.bag = Bag { tag: 8, xs: [2, if stop { return; } else { 3 }] };
}

fn main() { replace(true); }
