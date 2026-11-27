// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }

fn fresh() -> Node { Node {} }
fn linked(trim_last: bool) -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    let saved .= nodes[2];
    nodes.pop_n(1);
    fn restore(other: Node[..]&) {
        nodes.resize(nodes.cap, fresh());
        if trim_last { other.pop_n(1); }
    }
    restore(nodes);
    nodes[0].next .= saved;
    return nodes;
}

fn main() { let live: Node[] = linked(true); print(live.len); }
