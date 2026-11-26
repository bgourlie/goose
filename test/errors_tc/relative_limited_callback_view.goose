// error: retained storage may have a self-relative link to a removed element
struct Slot { link: i64&<u32>? }
struct List { slots: Slot[..2], values: i64[>..] }
fn invoke<F>() { F(); }

fn main() {
    var x = List { slots: [Slot {}], values: [42] };
    x.slots[0].link .= x.values[0];
    let saved .= x.slots[0];
    fn use_saved() { assert(saved.link != null); }
    x.slots.clear();
    x.values.clear();
    invoke(use_saved);
}
