struct Slot { link: i64&<u32>? }
struct List { first: Slot&<u32>?, slots: Slot[..2] = [Slot {}, Slot {}], values: i64[>..] }

fn replace(early: bool) {
    var x = List { values: [42] };
    x.first .= x.slots[1];
    x.slots[1].link .= x.values[0];
    x = block {
        if early { break List { const if true { slots: [Slot {}, Slot {}], }, values: [43] }; }
        List { const for <N> in [2] { slots: [Slot {}; N], }, values: [44] }
    };
    assert(x.first == null && x.slots[1].link == null);
    if early { assert(x.values[0] == 43); } else { assert(x.values[0] == 44); }
    x.first .= x.slots[1];
    x.slots[1].link .= x.values[0];
    x = loop {
        let value = block { break 45; };
        break List { values: [value] };
    };
    assert(x.first == null && x.slots[1].link == null && x.values[0] == 45);
}
fn main() { replace(true); replace(false); print("ok"); }
