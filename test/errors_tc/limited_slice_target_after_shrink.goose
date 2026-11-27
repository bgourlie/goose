// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }

fn saved_slice() -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    let view = nodes[1..];
    nodes.pop_n(1);
    nodes[0].next .= view[..][1];
    return nodes;
}

fn main() { let live: Node[] = saved_slice(); print(live.len); }
