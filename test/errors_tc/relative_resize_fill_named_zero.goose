// error: bound to a writable reference
struct Node { next: Node&<u32>? }
let length = 0;
fn fill(nodes: Node[>..]&) -> Node {
    nodes[0].next .= nodes[1];
    return Node {};
}
fn change(n: i64&) { n = 1; }
fn main() {
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes.resize(length, fill(nodes));
    change(length);
}
