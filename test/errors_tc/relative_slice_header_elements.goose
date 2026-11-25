// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
struct List { header: Node[1], nodes: Node[>..] }

fn link(view: Node[:], target: Node&) {
    for &n in view { n.next .= target; }
}

fn visit(use_tail: bool) {
    var list = List { header: [Node {}], nodes: [Node {}] };
    {
        let view = if use_tail { list.nodes[..] } else { list.header[..] };
        link(view, list.nodes[0]);
    }
    list.nodes.clear();
}
fn main() { visit(true); }
