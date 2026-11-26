// error: may still expose a limited-array slot
struct Slot { link: i64&<u32>? }
struct List { slots: Slot[..2], values: i64[>..] }
var shared = List { slots: [Slot {}], values: [42] };
var saved: Slot&? = null;
fn save() { saved .= shared.slots[0]; }
fn empty() {
    shared.slots[0].link .= shared.values[0];
    shared.slots.clear();
    shared.values.clear();
}
fn main() { save(); empty(); print(saved); }
