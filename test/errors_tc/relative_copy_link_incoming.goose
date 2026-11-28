// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn copy_link(nodes: Node[>..]&) {
    nodes[1].next .= nodes[0].next;
    nodes[0].next .= null;
    nodes.pop();
}

fn main() {
    var nodes: Node[>..] = [Node {}; 3];
    nodes[0].next .= nodes[2];
    copy_link(nodes);
}
