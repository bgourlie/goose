// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
struct List { header: Node[2], nodes: Node[>..] }
fn repoint(slot: (Node[:])&, replacement: Node[:]) { slot = replacement; }

fn main() {
    var list = List { header: [Node {}, Node {}], nodes: [Node {}, Node {}] };
    {
        let view = list.nodes[..];
        for &n in view {
            n.next .= list.nodes[0];
            repoint(view, list.header[..]);
        }
    }
    list.nodes.clear();
}
