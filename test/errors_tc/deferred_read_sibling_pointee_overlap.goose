// error: a defer on this exit can observe s.bag partially rebuilt
struct Slot { held: i64& }
struct Bag { tag: i64, xs: i64[>..] }
struct State { first: Slot, second: Slot, bag: Bag }

fn replace(which: bool, stop: bool) {
    var outside = 3;
    var s = State {
        first: Slot { held: outside }, second: Slot { held: outside }, bag: Bag { tag: 9, xs: [1] }
    };
    s.second.held .= s.bag.tag;
    let slot: Slot& = if which { s.first } else { s.second };
    defer { print(slot.held); }
    s.bag = Bag { tag: 8, xs: [2, if stop { return; } else { 3 }] };
}

fn main() { replace(false, true); }
