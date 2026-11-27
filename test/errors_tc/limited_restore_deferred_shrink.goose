// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }

fn fresh() -> Node { Node {} }
fn restore(nodes: Node[..]&) { nodes.resize(nodes.cap, fresh()); }
fn trim(nodes: Node[..]&) { nodes.pop_n(1); }
fn restore_then_trim(nodes: Node[..]&, alias: Node[..]&) {
    defer { trim(alias); }
    restore(nodes);
}

fn linked() -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    let last .= nodes[2];
    nodes.pop_n(1);
    restore_then_trim(nodes, nodes);
    nodes[0].next .= last;
    return nodes;
}

fn main() { let live: Node[] = linked(); print(live.len); }
