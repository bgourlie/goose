// error: a defer on this exit can observe s.bag partially rebuilt
struct Bag { tag: i64, flags: bool[>..] }
struct State { safe: i64, link: i64&<u32>?, bag: Bag }

fn replace(stop: bool) {
    var s = State { safe: 7, bag: Bag { tag: 9, flags: [true] } };
    fn observe() { print(s.link); s.link .= s.safe; }
    defer observe();
    s.link .= s.bag.tag;
    s.bag = Bag { tag: 8, flags: [true, if stop { return; } else { false }] };
}

fn main() { replace(true); }
