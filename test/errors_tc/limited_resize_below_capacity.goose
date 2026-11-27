// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }

fn linked() -> Node[..] {
    var nodes: Node[..] = [Node {}; 4];
    let last .= nodes[3];
    nodes.pop_n(1);
    nodes.resize(3);
    nodes[0].next .= last;
    return nodes;
}

fn main() { let live: Node[] = linked(); print(live.len); }
