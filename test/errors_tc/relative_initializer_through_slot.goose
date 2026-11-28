// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
fn main() {
    var nodes: Node[>..] = [Node {}; 2];
    {
        let views: (Node&)[2] = [nodes[1], nodes[0]];
        views[1] = Node { next: nodes[1] };
    }
    nodes.pop();
}
