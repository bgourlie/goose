// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }

fn views(nodes: Node[..]&) -> Node[:], Node[:] {
    let original: Node[:] = nodes;
    nodes.pop_n(1);
    return nodes[..], original;
}

fn forward(nodes: Node[..]&) -> Node[:], Node[:] { return views(nodes); }

fn linked() -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    let current, old = forward(nodes);
    current[0].next .= old[2];
    return nodes;
}

fn main() { let live: Node[] = linked(); print(live.len); }
