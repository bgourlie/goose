struct Node { next: Node&<u32>? }

fn main() {
    var nodes: Node[>..] = [Node {}, Node {}];
    fn trim() { nodes.pop_n(1); }
    fn reset() { nodes.clear(); }
    nodes[0].next .= nodes[1];
    nodes.clear();
    nodes.push(Node {});
    trim();

    nodes.push(Node {});
    nodes.push(Node {});
    nodes[0].next .= nodes[1];
    reset();
    nodes.push(Node {});
    trim();
    assert(nodes.len == 0);
    print("ok");
}
