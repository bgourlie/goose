// error: retained storage may have a self-relative link to a removed element
struct Node { value: i64 }
struct Slot { link: Node&<u32>? }
struct Header { slot: Slot }
struct List { header: Header, spare: Slot, nodes: Node[>..] }

fn format(out: u8[>..]&, slot: Slot&) { slot.link .= null; }

fn main() {
    var list = List { header: Header { slot: Slot {} }, spare: Slot {}, nodes: [Node { value: 1 }] };
    list.spare.link .= list.nodes[0];
    let rendered = str(list.header);
    list.nodes.clear();
}
