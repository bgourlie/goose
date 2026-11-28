// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn fill(nodes: Node[>..]&, i: i64) -> Node {
    nodes.push(Node {});
    nodes[i].next .= nodes[4];
    Node {}
}
fn run(i: i64) {
    var nodes: Node[>..] = [Node {}; 4];
    nodes.resize(4, fill(nodes, i));
}
fn main() { run(0); }
