// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }

fn link(nodes: Node[..]&) {
    let view = nodes[..];
    defer { nodes[0].next .= view[2]; }
    defer { nodes.pop_n(1); }
}

fn linked() -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    link(nodes);
    return nodes;
}

fn main() { let live: Node[] = linked(); print(live.len); }
