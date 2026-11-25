// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn reset(nodes: Node[>..]&?, skip: bool) {
    assert(nodes);
    if skip { return; }
    nodes.clear();
}

fn main() {
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    reset(nodes, true);
    nodes.pop_n(1);
}
