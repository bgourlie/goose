struct Item { saved: i64&<u32>?, n: i64 }
struct Items { spare: Item&<u32>?, value: i64, items: Item[>..] }
struct Slots { value: i64, slots: Item[2], tail: i64[>..] }

fn saved(value: i64&) -> Item { Item { saved: value, n: 2 } }
fn forwarded(value: i64&) -> Item { saved(value) }

fn main() {
    var x = Items { value: 17, items: [Item { n: 0 }, Item { n: 1 }] };
    x.items[0] = forwarded(x.value);
    x.items.pop_n(1);
    assert(x.items[0].saved .== x.value);

    var y = Slots { value: 17, slots: [Item { n: 0 }; 2], tail: [1, 2] };
    y.slots = [Item { saved: y.value, n: 2 }; 2];
    y.tail.clear();
    assert(y.slots[0].saved .== y.value && y.slots[1].saved .== y.value);
    print("ok");
}
