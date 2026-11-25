// error: retained storage may have a self-relative link to a removed element
struct Node { value: i64 }
struct Slot { link: Node&<u32>? }
struct Header { left: Slot, leftmost: Slot }
struct List { header: Header, nodes: Node[>..] }

fn edit(list: List&, left: bool) {
    let slot: Slot& = if left { list.header.left } else { list.header.leftmost };
    slot.link .= list.nodes[0];
    list.header.left = Slot {};
}

fn main() {
    var list = List { header: Header { left: Slot {}, leftmost: Slot {} }, nodes: [Node { value: 1 }] };
    edit(list, false);
    list.nodes.clear();
}
