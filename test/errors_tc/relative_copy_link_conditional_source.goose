// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn trim(change: bool) {
    var nodes: Node[>..] = [Node {}; 3];
    nodes[0].next .= nodes[0];
    if change { nodes[0].next .= nodes[2]; }
    nodes[1].next .= nodes[0].next;
    nodes[0].next .= null;
    nodes.pop();
}

fn main() { trim(true); }
