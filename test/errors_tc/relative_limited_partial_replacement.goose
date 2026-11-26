// error: retained storage may have a self-relative link to a removed element
struct Slot { link: i64&<u32>? }
struct List { slots: Slot[..2], values: i64[>..] }

fn main() {
    var x = List { slots: [Slot {}, Slot {}], values: [42] };
    x.slots[1].link .= x.values[0];
    let saved .= x.slots[1];
    x = List { slots: [Slot {}], values: [43] };
    assert(saved.link == null);
}
