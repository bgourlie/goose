// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn mark(nodes: Node[>..]&) -> i64 {
    nodes[0].next .= nodes[1];
    42
}

fn main() {
    var nodes: Node[>..] = [Node {}, Node {}];
    var assigned = [];
    assigned = [mark(nodes)];
    nodes.pop_n(1);
}
