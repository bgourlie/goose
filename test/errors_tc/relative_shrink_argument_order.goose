// error: cannot pop_n nodes: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn reset(nodes: Node[>..]&) -> i64 {
    nodes.clear();
    nodes.push(Node {});
    nodes.push(Node {});
    return 1;
}

fn link(nodes: Node[>..]&, index: i64) { nodes[0].next .= nodes[index]; }

fn main() {
    var nodes: Node[>..] = [Node {}, Node {}];
    link(nodes, reset(nodes));
    nodes.pop_n(1);
}
