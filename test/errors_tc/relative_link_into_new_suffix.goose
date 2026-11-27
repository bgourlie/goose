// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn connect(nodes: Node[>..]&) { nodes[0].next .= nodes[2]; }
fn main() {
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes.push(Node {});
    connect(nodes);
    nodes.pop_n(1);
}
