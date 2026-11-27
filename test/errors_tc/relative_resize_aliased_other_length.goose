// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn resize_to(nodes: Node[>..]&, source: Node[>..]&) {
    let other .= source;
    nodes.resize(other.len);
}

fn main() {
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    var shorter: Node[>..] = [Node {}];
    resize_to(nodes, shorter);
}
