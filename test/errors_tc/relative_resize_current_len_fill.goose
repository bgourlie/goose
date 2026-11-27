// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn fill(nodes: Node[>..]&) -> Node {
    nodes.push(Node {});
    return Node {};
}

fn main() {
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    let other .= nodes;
    nodes.resize(other.len, fill(nodes));
}
