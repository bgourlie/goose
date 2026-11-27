// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }

fn shortened() -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    nodes.pop_n(1);
    return nodes;
}
fn replacement(short: bool) -> Node[..] {
    if short { return shortened(); }
    [Node {}; 3]
}

fn linked(short: bool) -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    let saved .= nodes[2];
    nodes = replacement(short);
    nodes[0].next .= saved;
    return nodes;
}

fn main() { let live: Node[] = linked(true); print(live.len); }
