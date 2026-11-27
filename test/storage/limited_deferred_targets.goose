struct Node { next: Node&<u32>? }

fn link(nodes: Node[..]&) {
    let target .= nodes[1];
    let view = nodes[..];
    defer { nodes[0].next .= target; }
    defer { nodes[1].next .= view[0]; }
}

fn capture() -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    nodes.pop_n(1);
    link(nodes);
    return nodes;
}

fn rebind_before_store(nodes: Node[..]&) {
    var target .= nodes[2];
    defer { nodes[0].next .= target; }
    defer { target .= nodes[1]; }
    nodes.pop_n(1);
}

fn rebound() -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    rebind_before_store(nodes);
    return nodes;
}

fn main() {
    let pair: Node[] = capture();
    assert(pair[0].next .== pair[1] && pair[1].next .== pair[0]);
    let changed: Node[] = rebound();
    assert(changed[0].next .== changed[1]);
    print("ok");
}
