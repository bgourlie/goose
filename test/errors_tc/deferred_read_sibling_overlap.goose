// error: a defer on this exit can observe s.bag partially rebuilt
struct Bag { tag: i64, xs: i64[>..<] }
struct State { first: i64, bag: Bag }

fn replace(which: bool, stop: bool) {
    var s = State { first: 3, bag: Bag { tag: 9, xs: [1] } };
    let tag: i64& = if which { s.first } else { s.bag.tag };
    defer { print(tag); }
    s.bag = Bag { tag: 8, xs: [2, if stop { return; } else { 3 }] };
}

fn main() { replace(false, true); }
