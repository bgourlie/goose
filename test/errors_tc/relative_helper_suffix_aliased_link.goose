// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn trim(nodes: Node[>..]&, dst: Node&, src: Node&) { dst.next .= src; nodes.pop(); }

fn main() {
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes.push(Node {});
    trim(nodes, nodes[0], nodes[2]);
}
