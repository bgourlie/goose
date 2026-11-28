// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn main() {
    var nodes: Node[>..] = [Node {}; 3];
    nodes[2].next .= nodes[1];
    nodes[0].next .= nodes[2].next;
    nodes[2].next .= null;
    nodes.pop_n(2);
}
