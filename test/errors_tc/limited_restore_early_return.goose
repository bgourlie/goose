// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }

fn fresh() -> Node { Node {} }
fn maybe_restore(nodes: Node[..]&, skip: bool) {
    if skip { return; }
    nodes.resize(nodes.cap, fresh());
}

fn linked(skip: bool) -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    let last .= nodes[2];
    nodes.pop_n(1);
    maybe_restore(nodes, skip);
    nodes[0].next .= last;
    return nodes;
}

fn main() { let live: Node[] = linked(true); print(live.len); }
