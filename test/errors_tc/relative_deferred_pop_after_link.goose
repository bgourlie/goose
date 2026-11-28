// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn main() {
    var nodes: Node[>..] = [Node {}];
    nodes.push(Node {});
    defer { nodes.pop(); }
    defer { nodes[0].next .= nodes[1]; }
}
