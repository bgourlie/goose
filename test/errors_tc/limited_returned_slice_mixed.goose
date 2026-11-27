// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }

fn choose(nodes: Node[..]&, saved: Node[:], first: bool) -> Node[:] {
    if first { return nodes[..]; }
    return saved;
}

fn linked(first: bool) -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    let original: Node[:] = nodes;
    nodes.pop_n(1);
    nodes[0].next .= choose(nodes, original, first)[2];
    return nodes;
}

fn main() { let live: Node[] = linked(false); print(live.len); }
