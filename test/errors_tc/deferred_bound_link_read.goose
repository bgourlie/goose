// error: a defer on this exit can observe s.bag partially rebuilt
struct Bag { tag: i64, flags: bool[>..] }
struct State { link: i64&<u32>?, bag: Bag }

fn replace(stop: bool) {
    var s = State { bag: Bag { tag: 9, flags: [true] } };
    s.link .= s.bag.tag;
    fn observe() { let at .= s.link; print(at); }
    defer observe();
    s.bag = Bag { tag: 8, flags: [true, if stop { return; } else { false }] };
}

fn main() { replace(true); }
