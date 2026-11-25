struct Node { value: i64 }
struct Slot { link: Node&<u32>? }
struct Header { slot: Slot }
struct List { header: Header, spare: Slot, nodes: Node[>..] }

fn format(out: u8[>..]&, slot: Slot&) {
    slot.link .= null;
    out.append("reset");
}

fn main() {
    var list = List { header: Header { slot: Slot {} }, spare: Slot {}, nodes: [Node { value: 1 }] };
    list.header.slot.link .= list.nodes[0];
    let rendered = str(list.header);
    assert(rendered.len > 0 && list.header.slot.link == null);
    list.nodes.clear();
    print("ok");
}
