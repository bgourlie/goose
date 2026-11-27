// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn trim(add: bool) {
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    if add { nodes.push(Node {}); }
    nodes.pop_n(1);
}

fn main() { trim(false); }
