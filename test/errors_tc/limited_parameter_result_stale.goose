// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }

fn choose(a: Node&, b: Node&, first: bool) -> Node& { if first { a } else { b } }

fn pair() -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    let stale .= nodes[2];
    nodes.pop_n(1);
    nodes[0].next .= choose(nodes[1], stale, false);
    return nodes;
}

fn main() { let live: Node[] = pair(); print(live.len); }
