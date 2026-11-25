// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn link(nodes: Node[>..]&) { nodes[0].next .= nodes[1]; }

fn rebuild(nodes: Node[>..]&) {
    defer { link(nodes); }
    nodes.clear();
    nodes.push(Node {});
    nodes.push(Node {});
}

fn trim(keep: i64) {
    var nodes: Node[>..] = [];
    rebuild(nodes);
    nodes.resize(keep);
}

fn main() { trim(2); }
