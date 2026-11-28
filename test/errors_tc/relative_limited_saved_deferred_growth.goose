// error: retained storage may have a self-relative link to a removed element
struct Slot { link: i64&<u32>? }
struct List { slots: Slot[..2], values: i64[>..] }
fn main() {
    var x = List { slots: [Slot {}], values: [42] };
    const n = x.slots.len;
    defer { x.slots.pop_n(n); x.values.clear(); }
    x.slots.push(Slot {});
    x.slots[0].link .= x.values[0];
}
