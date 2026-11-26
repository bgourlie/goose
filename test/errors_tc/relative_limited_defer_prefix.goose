// error: retained storage may have a self-relative link to a removed element
struct Slot { link: i64&<u32>? }
struct List { saved: Slot&<u32>?, slots: Slot[..2], values: i64[>..] }

fn main() {
    var x = List { slots: [Slot {}], values: [42] };
    x.slots[0].link .= x.values[0];
    defer { let saved .= x.saved; if saved { assert(saved.link != null); } }
    defer { x.values.clear(); }
    defer { x.slots.clear(); }
    x.saved .= x.slots[0];
}
