// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }

fn make(target: Node&, nodes: Node[..]&) -> Node {
    defer { nodes.pop_n(1); }
    Node { next: target }
}

fn pair() -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    nodes[0] = make(nodes[2], nodes);
    return nodes;
}

fn main() { let live: Node[] = pair(); print(live.len); }
