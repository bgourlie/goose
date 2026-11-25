struct Node { flag: bool }
struct List { value: i64, saved: i64&<u32>?, first: Node&<u32>?, nodes: Node[>..] }

fn link_header(list: List&) { list.saved .= list.value; }
fn clear(list: List&) { list.nodes.clear(); }

var global_list = List { value: 7, nodes: [Node { flag: true }] };
fn clear_global() { global_list.nodes.clear(); }

struct Item { prev: Item&<u32>?, saved: i64&<u64>? }
struct Items { value: i64, items: Item[>..] }

fn saved(value: i64&) -> Item { Item { saved: value } }
fn forward(value: i64&) -> Item { saved(value) }

fn mixed_directions() {
    var list = Items { value: 17, items: [Item {}] };
    list.items[0] = forward(list.value);
    list.items.push(Item { prev: list.items[0] });
    list.items.pop_n(1);
    assert(list.items.len == 1 && list.items[0].saved .== list.value);
}

fn main() {
    var list = List { value: 42, nodes: [Node { flag: true }] };
    link_header(list);
    clear(list);
    assert(list.saved .== list.value && list.nodes.len == 0);

    link_header(global_list);
    clear_global();
    assert(global_list.saved .== global_list.value && global_list.nodes.len == 0);
    mixed_directions();
    print("ok");
}
