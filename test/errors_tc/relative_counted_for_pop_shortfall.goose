// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
var nodes: Node[>..] = [Node {}; 2];
fn trim() {
    for i in 2 {
        defer { nodes.pop(); }
        continue;
    }
}
fn main() {
    nodes[0].next .= nodes[1];
    nodes.push(Node {});
    trim();
}
