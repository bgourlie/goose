// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }

fn pair() -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    let stale .= nodes[2];
    nodes.pop_n(1);
    var last .= nodes[1];
    fn change() { last .= stale; }
    { defer { change(); } }
    nodes[0].next .= last;
    return nodes;
}

fn main() { let live: Node[] = pair(); print(live.len); }
