// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
fn main() {
    var nodes: Node[>..] = [Node {}; 2];
    nodes[0] = Node { next: nodes[1] };
    nodes.pop();
}
