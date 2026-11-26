struct Bag { tag: i64[1], flags: bool[>..] }
struct Slot { link: i64&<u32>? }
struct State { safe: i64, link: i64&<u32>?, alias: i64&, view: i64[:], slots: Slot[..2], bag: Bag }

fn replace(stop: bool) {
    var outside: i64[1] = [3];
    var s = State { safe: 7, alias: outside[0], view: outside[..], slots: [Slot {}], bag: Bag { tag: [9], flags: [true] } };
    s.alias .= s.bag.tag[0];
    s.view = s.bag.tag[..];
    s.link .= s.bag.tag[0];
    s.slots[0].link .= s.bag.tag[0];
    fn observe() { print(s.link); }
    fn present() -> bool { let bound .= s.link; return bound != null; }
    defer observe();
    defer {
        assert(s.link != null);
        assert(present());
        assert(s.slots.len == 1 && s.slots.cap == 2);
        s.alias .= outside[0];
        s.view = outside[..];
        s.link .= s.safe;
        observe();
    }
    s.bag = Bag { tag: [8], flags: [true, if stop { return; } else { false }] };
}

fn main() {
    replace(true);
    replace(false);
    print("ok");
}
