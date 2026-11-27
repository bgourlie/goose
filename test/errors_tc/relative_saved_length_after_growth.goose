// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn extend(nodes: Node[>..]&) { nodes.push(Node {}); }
fn main() {
    var nodes: Node[>..] = [Node {}];
    const size = nodes.len;
    { defer extend(nodes); }
    nodes[0].next .= nodes[1];
    nodes.resize(size);
}
