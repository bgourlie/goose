// error: retained storage may have a self-relative link to a removed element
struct Slot { link: i64&<u32>? }
struct List { slots: Slot[..2], values: i64[>..] }
fn replace(full: bool) {
    var x = List { slots: [Slot {}, Slot {}], values: [42] };
    let saved .= x.slots[1];
    x.slots[1].link .= x.values[0];
    x = loop {
        if full { break List { slots: [Slot {}, Slot {}], values: [43] }; }
        break List { const if true { slots: [Slot {}], }, values: [44] };
    };
    assert(saved.link == null);
}
fn main() { replace(false); }
