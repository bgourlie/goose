// error: retained storage may have a self-relative link to a removed element
struct Node { value: i64 }
struct Slot { link: Node&<u32>? }
struct List { left: Slot, right: Slot, nodes: Node[>..] }

fn choose(a: Slot&, b: Slot&, first: bool) -> Slot& {
    if first { return a; }
    return b;
}
fn main() {
    var list = List { left: Slot {}, right: Slot {}, nodes: [Node { value: 1 }] };
    list.left.link .= list.nodes[0];
    choose(list.left, list.right, false).link .= null;
    list.nodes.clear();
}
