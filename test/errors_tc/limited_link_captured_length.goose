// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }

fn pair() -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    fn last() -> i64 { nodes.pop_n(1); return 2; }
    let old .= nodes[last()];
    nodes[0].next .= old;
    nodes[1].next .= nodes[0];
    return nodes;
}

fn main() { let live: Node[] = pair(); print(live.len); }
