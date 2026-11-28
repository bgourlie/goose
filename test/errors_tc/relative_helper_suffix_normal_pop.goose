// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn trim(nodes: Node[>..]&, early: bool) {
    fn maybe_pop() { if early { return from trim; } nodes.pop(); }
    maybe_pop();
    nodes.pop();
}

fn main() {
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    nodes.push(Node {});
    trim(nodes, false);
}
