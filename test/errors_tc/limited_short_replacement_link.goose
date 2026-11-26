// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }

fn shortened() -> Node[..] {
    var nodes: Node[..] = [Node {}, Node {}];
    let last .= nodes[1];
    nodes = [Node {}];
    nodes[0].next .= last;
    return nodes;
}

fn main() { let live: Node[] = shortened(); print(live.len); }
