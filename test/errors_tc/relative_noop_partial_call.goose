// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn trim(nodes: Node[>..]&, remove: bool) {
    nodes.pop_n(0);
    if remove { nodes.pop_n(1); }
    nodes.resize(nodes.len);
}

fn main() {
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    trim(nodes, false);
}
