// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }

fn pair(present: bool) -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    let last .= nodes[2];
    nodes.pop_n(1);
    let target: Node&?;
    if present { target .= last; } else { target .= null; }
    nodes[0].next .= target;
    return nodes;
}

fn main() { let live: Node[] = pair(true); print(live.len); }
