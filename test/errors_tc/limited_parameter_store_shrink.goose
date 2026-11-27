// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }

fn store(slot: Node&, target: Node&, nodes: Node[..]&) {
    slot.next .= target;
    nodes.pop_n(1);
}

fn pair() -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    store(nodes[0], nodes[2], nodes);
    return nodes;
}

fn main() { let live: Node[] = pair(); print(live.len); }
