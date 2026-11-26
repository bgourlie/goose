// error: a defer on this exit can observe state.bag partially rebuilt
struct Bag { tag: i64, xs: i64[>..<] }
struct State { tag: i64, bag: Bag }

fn replace(stop: bool, redirect: bool) {
    var state = State { tag: 7, bag: Bag { tag: 9, xs: [1] } };
    var tag .= state.bag.tag;
    fn observe() {
        if redirect { tag .= state.tag; }
        print(tag);
    }
    defer observe();
    state.bag = Bag { tag: 8, xs: [2, if stop { return; } else { 3 }] };
}

fn main() { replace(true, false); }
