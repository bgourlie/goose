// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
fn visit(nodes: Node[>..]&, early: bool) {
    if early {
        nodes[0].next .= nodes[1];
        return from outer;
    }
}
fn outer(early: bool) {
    var nodes: Node[>..] = [Node {}, Node {}];
    defer { nodes.pop_n(1); }
    visit(nodes, early);
}
fn main() { outer(true); }
