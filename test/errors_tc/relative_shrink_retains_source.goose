// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
fn main() {
    var nodes: Node[>..] = [Node {}; 4];
    nodes[2].next .= nodes[3];
    nodes.resize(3);
}
