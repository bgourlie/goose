// error: retained storage may have a self-relative link to a removed element
struct Slot { link: i64&<u32>? }
struct List { slots: Slot[..2], values: i64[>..] }
fn add(slots: Slot[..2]&) { slots.push(Slot {}); }
fn main() {
    var x = List { slots: [Slot {}], values: [42] };
    const n = x.slots.len;
    add(x.slots);
    x.slots[0].link .= x.values[0];
    x.slots.pop_n(n);
    x.values.clear();
}
