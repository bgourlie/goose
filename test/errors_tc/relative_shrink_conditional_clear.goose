// error: cannot pop_n nodes: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn maybe_clear(nodes: Node[>..]&, keep: bool) {
    if keep { return; }
    nodes.clear();
}

fn main() {
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    maybe_clear(nodes, nodes.len > 1);
    nodes.pop_n(1);
}
