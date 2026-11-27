// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }

fn fresh() -> Node { Node {} }
fn prepare(first: Node[..]&, second: Node[..]&) {
    first.pop_n(1);
    second.resize(second.cap, fresh());
}

fn linked() -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    var other: Node[..] = [Node {}; 3];
    let last .= nodes[2];
    prepare(nodes, other);
    nodes[0].next .= last;
    return nodes;
}

fn main() { let live: Node[] = linked(); print(live.len); }
