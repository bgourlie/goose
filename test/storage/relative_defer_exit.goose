struct Node { next: Node&<u32>? }

fn reset(nodes: Node[>..]&, early: bool) {
    defer { nodes.clear(); }
    defer { nodes[0].next .= nodes[1]; }
    if early { return; }
}

fn main() {
    var nodes: Node[>..] = [Node {}, Node {}];
    { defer { nodes[0].next .= nodes[1]; } }
    nodes.clear();
    nodes.push(Node {});
    nodes.pop_n(1);
    for i in 2 {
        nodes.push(Node {});
        nodes.push(Node {});
        defer { nodes.clear(); }
        defer { nodes[0].next .= nodes[1]; }
        if i == 0 { continue; }
        break;
    }
    for i in 2 {
        nodes.push(Node {});
        nodes.push(Node {});
        reset(nodes, i == 0);
        nodes.push(Node {});
        nodes.pop_n(1);
    }
    assert(nodes.len == 0);
    print("ok");
}
