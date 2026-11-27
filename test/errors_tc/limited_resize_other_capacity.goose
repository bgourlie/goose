// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }

fn pair() -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    var shorter: i64[..] = [1];
    nodes[0].next .= nodes[2];
    nodes.resize(nodes.cap);
    nodes.resize(shorter.cap);
    return nodes;
}

fn main() { let live: Node[] = pair(); print(live.len); }
