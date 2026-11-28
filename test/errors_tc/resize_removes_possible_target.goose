// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn trim(nodes: Node[>..]&) { nodes.resize(3); }
fn run(i: i64, j: i64) {
    var nodes: Node[>..] = [Node {}; 4];
    nodes[i].next .= nodes[j];
    trim(nodes);
}
fn main() { run(0, 3); }
