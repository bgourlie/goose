// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn advance(nodes: Node[>..]&, index: i64&) -> Node[>..]& {
    index = index + 1;
    return nodes;
}

fn forward(nodes: Node[>..]&) -> Node[>..]& { nodes }

fn view(nodes: Node[>..]&, i: i64&) -> Node[>..]& {
    if i > 0 { return forward(nodes); }
    return forward(advance(nodes, i));
}

fn main() {
    var nodes: Node[>..] = [Node {}, Node {}];
    var i = 0;
    nodes[i].next .= view(nodes, i)[i];
    nodes.pop_n(1);
}
