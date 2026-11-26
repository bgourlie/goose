// error: a defer on this exit can observe state.bag partially rebuilt
struct Bag { tag: i64, xs: i64[>..<] }
struct State { tag: i64, bag: Bag }

fn replace(choice: i64, stop: bool) {
    var state = State { tag: 7, bag: Bag { tag: 9, xs: [1] } };
    var tag .= state.tag;
    fn choose(a: i64&, b: i64&, c: i64&, d: i64&, e: i64&) {
        if choice == 0 { tag .= a; }
        else if choice == 1 { tag .= b; }
        else if choice == 2 { tag .= c; }
        else if choice == 3 { tag .= d; }
        else { tag .= e; }
    }
    choose(state.bag.tag, state.tag, state.tag, state.tag, state.tag);
    defer { print(tag); }
    state.bag = Bag { tag: 8, xs: [2, if stop { return; } else { 3 }] };
}

fn main() { replace(0, true); }
