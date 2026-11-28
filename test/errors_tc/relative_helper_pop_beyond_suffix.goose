// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn pop_one(nodes: Node[>..]&) { nodes.pop(); }
fn pop_two(nodes: Node[>..]&) { pop_one(nodes); pop_one(nodes); }

fn main() {
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    nodes.push(Node {});
    pop_two(nodes);
}
