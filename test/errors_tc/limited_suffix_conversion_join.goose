// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }

fn result(clear: bool) -> Node[..] {
    var nodes: Node[..] = [Node {}; 2];
    nodes[0].next .= nodes[1];
    let old .= nodes[0];
    if clear { nodes.clear(); } else { nodes.pop_n(1); }
    assert(old.next != null);
    return nodes;
}

fn main() { let live: Node[] = result(false); print(live.len); }
