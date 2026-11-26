// error: a defer on this exit can observe s.bag partially rebuilt
struct Slot { link: i64&<u32>? }
struct Bag { tag: i64, flags: bool[>..] }
struct State { via: Slot&<u32>?, slot: Slot, bag: Bag }

fn replace(stop: bool) {
    var s = State { slot: Slot {}, bag: Bag { tag: 9, flags: [true] } };
    s.slot.link .= s.bag.tag;
    s.via .= s.slot;
    defer { print(s.via); }
    s.bag = Bag { tag: 8, flags: [true, if stop { return; } else { false }] };
}

fn main() { replace(true); }
