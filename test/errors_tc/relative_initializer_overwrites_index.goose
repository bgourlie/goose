// error: retained storage may have a self-relative link to a removed element
struct Node { index: i64 = 0, next: Node&<u32>? }
fn main() {
    var nodes: Node[>..] = [Node {}; 2];
    nodes[nodes[0].index] = Node { index: 1, next: nodes[nodes[0].index] };
    nodes.pop();
}
