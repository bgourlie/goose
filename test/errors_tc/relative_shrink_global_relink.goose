// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

var nodes: Node[>..] = [];
fn link() { nodes[0].next .= nodes[1]; }

fn trim(keep: i64) {
    nodes.clear();
    nodes.push(Node {});
    nodes.push(Node {});
    link();
    nodes.resize(keep);
}

fn main() { trim(2); }
