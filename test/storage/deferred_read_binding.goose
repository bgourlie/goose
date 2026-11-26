struct Bag { tag: i64, xs: i64[>..<] }
struct State { tag: i64, bag: Bag }

fn sibling(stop: bool) {
    var bag = Bag { tag: 7, xs: [1] };
    var tag .= bag.tag;
    defer { assert(tag == 7); }
    bag.xs = [2, if stop { return; } else { 3 }];
}

fn rebound(stop: bool, earlier_defer: bool) {
    var state = State { tag: 7, bag: Bag { tag: 9, xs: [1] } };
    var tag .= state.bag.tag;
    recursive fn observe(depth: i64) {
        if depth == 0 { assert(tag == 7); }
        else { observe(depth - 1); }
    }
    fn relay() { observe(1); }
    if earlier_defer {
        defer relay();
        defer { tag .= state.tag; }
        state.bag = Bag { tag: 8, xs: [2, if stop { return; } else { 3 }] };
    } else {
        defer {
            tag .= state.tag;
            relay();
        }
        state.bag = Bag { tag: 8, xs: [2, if stop { return; } else { 3 }] };
    }
}

fn from_helper(stop: bool) {
    var state = State { tag: 7, bag: Bag { tag: 9, xs: [1] } };
    var tag .= state.bag.tag;
    fn redirect() {
        tag .= state.tag;
        assert(tag == 7);
    }
    defer redirect();
    state.bag = Bag { tag: 8, xs: [2, if stop { return; } else { 3 }] };
}

fn stopped(enter: bool) {
    var bag = Bag { tag: 7, xs: [1] };
    if enter {
        defer {
            defer { print(bag.xs.len); }
            abort("stop");
        }
        bag.xs = [2, if enter { return; } else { 3 }];
    }
}

fn main() {
    sibling(true);
    sibling(false);
    rebound(true, true);
    rebound(true, false);
    rebound(false, true);
    rebound(false, false);
    from_helper(true);
    from_helper(false);
    stopped(false);
    print("ok");
}
