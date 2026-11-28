// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn trim(first: Node[>..]&, second: Node[>..]&) {
    first.pop();
    second.pop();
}

fn main() {
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    nodes.push(Node {});
    trim(nodes, nodes);
}
