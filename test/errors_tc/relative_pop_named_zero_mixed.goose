// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
let zero_count = 0;

fn trim(nodes: Node[>..]&, remove: bool) {
    if remove { nodes.pop_n(1); }
    nodes.pop_n(zero_count);
}

fn main() {
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    trim(nodes, true);
}
