struct Slot { link: i64&<u32>? }
struct List { slots: Slot[..2], values: i64[>..] }
var shared = List { slots: [Slot {}], values: [42] };

fn empty_shared() {
    shared.slots[0].link .= shared.values[0];
    shared.slots.clear();
    shared.values.clear();
}

fn main() {
    var x = List { slots: [Slot {}], values: [42] };
    fn empty_captured() {
        x.slots[0].link .= x.values[0];
        x.slots.clear();
        x.values.clear();
    }
    empty_captured();
    empty_shared();
    assert(x.values.len == 0 && shared.values.len == 0);
    print("ok");
}
