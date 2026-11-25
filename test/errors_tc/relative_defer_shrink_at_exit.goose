// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn visit(nodes: Node[>..]&, count: i64) {
    defer { nodes.pop_n(count); }
    nodes[0].next .= nodes[1];
}

fn main() {
    var nodes: Node[>..] = [Node {}, Node {}];
    visit(nodes, 0);
}
