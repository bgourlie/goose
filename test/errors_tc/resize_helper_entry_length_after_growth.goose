// error: cannot prove the array has at most 3 elements on entry
struct Node { next: Node&<u32>? }
fn link_and_resize(nodes: Node[>..]&, i: i64, j: i64) {
    nodes[i].next .= nodes[j];
    nodes.resize(4);
}
fn grow_and_link(nodes: Node[>..]&) {
    nodes.push(Node {});
    link_and_resize(nodes, 0, 4);
}
fn main() {
    var nodes: Node[>..] = [Node {}; 4];
    grow_and_link(nodes);
}
