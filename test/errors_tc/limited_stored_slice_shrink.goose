// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }

fn store(slot: Node&, view: Node[:], nodes: Node[..]&) {
    nodes.pop_n(1);
    slot.next .= view[2];
}

fn linked() -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    store(nodes[0], nodes[..], nodes);
    return nodes;
}

fn main() { let live: Node[] = linked(); print(live.len); }
