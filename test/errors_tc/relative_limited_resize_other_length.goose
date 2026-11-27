// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }

fn shortened() -> Node[..] {
    var nodes: Node[..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    let other = [0];
    resize(&nodes, (&other).len);
    return nodes;
}

fn main() { let prefix: Node[] = shortened(); print(prefix.len); }
