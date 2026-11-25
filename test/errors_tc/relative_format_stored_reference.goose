// error: retained storage may have a self-relative link to a removed element
struct Node { value: i64 }
struct Slot { seed: Node&<u32>?, link: Node&<u32>? }
struct View { slot: Slot&<u32>? }
struct List { view: View, slot: Slot, nodes: Node[>..] }

fn format(out: u8[>..]&, slot: Slot&) { slot.link .= slot.seed; }

fn main() {
    var list = List { view: View {}, slot: Slot {}, nodes: [Node { value: 1 }] };
    list.slot.seed .= list.nodes[0];
    list.view.slot .= list.slot;
    let rendered = str(list.view);
    list.slot.seed .= null;
    list.view = View {};
    list.nodes.clear();
}
