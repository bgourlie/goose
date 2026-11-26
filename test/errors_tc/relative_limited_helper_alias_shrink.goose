// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }

fn link_then_trim(nodes: Node[..]&, other: Node[..]&, trim: bool) {
    nodes[0].next .= nodes[2];
    if trim { other.pop_n(1); }
}

fn pair() -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    link_then_trim(nodes, nodes, true);
    return nodes;
}

fn main() { let live: Node[] = pair(); print(live.len); }
