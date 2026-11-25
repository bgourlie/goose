struct Node { next: Node&<u32>? }

fn visit(nodes: Node[>..]&, early: bool) {
    if early { return from separate; }
    nodes[0].next .= nodes[1];
}
fn separate(early: bool) {
    var nodes: Node[>..] = [Node {}, Node {}];
    defer { nodes.pop_n(1); }
    visit(nodes, early);
    nodes.clear();
    nodes.push(Node {});
}

fn reset(nodes: Node[>..]&, early: bool) {
    if early {
        nodes.clear();
        nodes.push(Node {});
        return from overwritten;
    }
}
fn forward(nodes: Node[>..]&, early: bool) { reset(nodes, early); }
fn overwritten(early: bool) {
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    defer { nodes.pop_n(1); }
    forward(nodes, early);
    nodes.clear();
    nodes.push(Node {});
}
fn main() {
    for early in [true, false] {
        separate(early);
        overwritten(early);
    }
    print("ok");
}
