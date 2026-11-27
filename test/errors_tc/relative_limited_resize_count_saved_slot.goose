// error: retained storage may have a self-relative link to a removed element
struct Slot { link: i64&<u32>? }
struct List { slots: Slot[..2], values: i64[>..] }
let count = 0;
fn empty(list: List&) { list.slots.resize(count); }

fn main() {
    var list = List { slots: [Slot {}], values: [42] };
    list.slots[0].link .= list.values[0];
    let saved .= list.slots[0];
    empty(list);
    list.values.clear();
    assert(saved.link != null);
}
