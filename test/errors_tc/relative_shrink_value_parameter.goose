// error: cannot pop_n nodes: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn linked() -> Node[>..] {
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    return nodes;
}

fn trim(nodes: Node[>..]) { nodes.pop_n(1); }

fn main() {
    trim([Node {}, Node {}]);
    trim(linked());
}
