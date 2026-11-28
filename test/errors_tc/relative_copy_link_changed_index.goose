// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>?, alt: Node&<u32>? }
fn copy(nodes: Node[>..]&, var i: i64) {
    nodes[i].next .= nodes[0];
    i = 0;
    nodes[i].alt .= nodes[i].next;
    nodes[i].next .= null;
    nodes.pop();
}
fn main() {
    var nodes: Node[>..] = [Node {}; 3];
    nodes[0].next .= nodes[2];
    copy(nodes, 1);
}
