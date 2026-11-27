// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }

fn bounded() -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    fn end() -> i64 { nodes.pop_n(1); return 3; }
    nodes[0].next .= nodes[..end()][2];
    return nodes;
}

fn main() { let live: Node[] = bounded(); print(live.len); }
