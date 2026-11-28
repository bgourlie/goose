// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn trim(nodes: Node[>..]&, scratch: Node[>..]&) {
    const size = nodes.len;
    scratch.push(Node {});
    scratch[0].next .= scratch[1];
    nodes.resize(size);
}

fn main() {
    var nodes: Node[>..] = [Node {}];
    trim(nodes, nodes);
}
