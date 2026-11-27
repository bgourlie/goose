// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }
struct Bag { items: Node[..] }

fn fresh() -> Node { Node {} }
fn prepare(target: Node[..]&, writer: Node[..]&) {
    target.resize(target.cap, fresh());
    writer.pop_n(1);
}
fn forward(target: Node[..]&, obj: Bag&, other: Node[..]&, use_other: bool) {
    var writer .= obj.items;
    if use_other { writer .= other; }
    prepare(target, writer);
}
fn linked(use_other: bool) -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    var bag = Bag { items: [Node {}; 3] };
    let saved .= nodes[2];
    nodes.pop_n(1);
    forward(nodes, bag, nodes, use_other);
    nodes[0].next .= saved;
    return nodes;
}

fn main() { let live: Node[] = linked(true); print(live.len); }
