// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }

fn make(first: Node&, second: Node&) -> Node { Node { next: second } }

fn pair() -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    let stale .= nodes[2];
    nodes.pop_n(1);
    nodes[0] = make(nodes[1], stale);
    return nodes;
}

fn main() { let live: Node[] = pair(); print(live.len); }
