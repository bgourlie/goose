// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }

fn indexed() -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    fn last() -> i64 { nodes.pop_n(1); return 2; }
    nodes[0].next .= nodes[..][last()];
    return nodes;
}

fn main() { let live: Node[] = indexed(); print(live.len); }
