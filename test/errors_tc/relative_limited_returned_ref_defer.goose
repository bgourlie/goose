// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }

fn target(nodes: Node[..]&, trim: bool) -> Node& {
    if trim {
        defer { nodes.pop_n(1); }
        return nodes[2];
    }
    return nodes[1];
}

fn pair() -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    nodes[0].next .= target(nodes, true);
    return nodes;
}

fn main() { let live: Node[] = pair(); print(live.len); }
