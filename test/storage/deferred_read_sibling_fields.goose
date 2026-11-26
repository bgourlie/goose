struct Slot { tag: i64, held: i64& }
struct Bag { tag: i64, xs: i64[>..] }
struct State { first: Slot, second: Slot, third: Slot, bag: Bag }

fn replace(which: bool, stop: bool) {
    var outside = 3;
    var s = State {
        first: Slot { tag: 4, held: outside }, second: Slot { tag: 5, held: outside },
        third: Slot { tag: 6, held: outside }, bag: Bag { tag: 9, xs: [1] }
    };
    s.third.held .= s.bag.tag;
    let tag: i64& = if which { s.first.tag } else { s.second.tag };
    fn choose(a: Slot&, b: Slot&) -> Slot& { if which { a } else { b } }
    let slot: Slot& = choose(s.first, s.second);
    let expected = if which { 4 } else { 5 };
    defer {
        assert(tag == expected);
        assert(slot.held == 3);
    }
    s.bag = Bag { tag: 8, xs: [2, if stop { return; } else { 3 }] };
}

fn main() {
    for which in [true, false] { replace(which, true); replace(which, false); }
    print("ok");
}
