// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }

fn before_shrink(nodes: Node[..]&) -> Node[:] {
    defer { nodes.pop_n(1); }
    return nodes;
}

fn linked() -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    let saved = before_shrink(nodes);
    nodes[0].next .= saved[2];
    return nodes;
}

fn main() { let live: Node[] = linked(); print(live.len); }
