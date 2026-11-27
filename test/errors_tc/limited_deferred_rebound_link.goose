// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }

fn link(nodes: Node[..]&, change: bool) {
    let last .= nodes[2];
    nodes.pop_n(1);
    var target .= nodes[1];
    defer { nodes[0].next .= target; }
    if !change { return; }
    target .= last;
}

fn linked(change: bool) -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    link(nodes, change);
    return nodes;
}

fn main() { let live: Node[] = linked(true); print(live.len); }
