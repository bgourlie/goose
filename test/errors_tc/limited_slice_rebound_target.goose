// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }

fn rebound() -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    let original = nodes[..];
    nodes.pop_n(1);
    var selected = nodes[..];
    fn restore() { selected = original; }
    restore();
    nodes[0].next .= selected[2];
    return nodes;
}

fn main() { let live: Node[] = rebound(); print(live.len); }
