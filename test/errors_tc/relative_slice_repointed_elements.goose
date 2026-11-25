// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
struct List { header: Node[1], nodes: Node[>..] }
fn repoint(slot: (Node[:])&, replacement: Node[:]) { slot = replacement; }

fn main() {
    var list = List { header: [Node {}], nodes: [Node {}] };
    {
        let view = list.nodes[..];
        repoint(view, list.header[..]);
        view[0].next .= list.nodes[0];
    }
    list.nodes.clear();
}
