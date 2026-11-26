// error: a defer on this exit can observe state.bag partially rebuilt
struct Bag { tag: i64, xs: i64[>..<] }
struct State { tag: i64, bag: Bag }

fn replace(stop: bool) {
    var state = State { tag: 7, bag: Bag { tag: 9, xs: [1] } };
    var tag .= state.tag;
    recursive fn bind(first: i64&, second: i64&, depth: i64) {
        tag .= first;
        if depth > 0 { bind(second, first, depth - 1); }
    }
    bind(state.tag, state.bag.tag, 1);
    defer { print(tag); }
    state.bag = Bag { tag: 8, xs: [2, if stop { return; } else { 3 }] };
}

fn main() { replace(true); }
