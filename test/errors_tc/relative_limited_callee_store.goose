// error: retained storage may have a self-relative link to a removed element
struct Slot { link: i64&<u32>? }
struct List { slots: Slot[..2], values: i64[>..] }

fn prepare(x: List&) {
    x.slots[0].link .= x.values[0];
    x.slots.clear();
}

fn main() {
    var x = List { slots: [Slot {}], values: [42] };
    let saved .= x.slots[0];
    prepare(x);
    x.values.clear();
    assert(saved.link != null);
}
