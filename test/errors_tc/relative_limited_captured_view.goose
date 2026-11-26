// error: retained storage may have a self-relative link to a removed element
struct Slot { link: i64&<u32>? }
struct List { slots: Slot[..2], values: i64[>..] }
fn main() {
    var x = List { slots: [Slot {}], values: [42] };
    fn empty() {
        x.slots[0].link .= x.values[0];
        x.slots.clear();
        x.values.clear();
    }
    empty();
    x.slots.push(Slot {});
    x.values.push(43);
    let saved .= x.slots[0];
    empty();
    assert(saved.link == null);
}
