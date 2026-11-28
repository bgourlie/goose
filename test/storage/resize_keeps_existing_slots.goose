struct Node { next: Node&<u32>? }

fn empty_node() -> Node { Node {} }
fn resize_four(nodes: Node[>..]&) { nodes.resize(4); }
fn extend_to_five(nodes: Node[>..]&) { nodes.resize(5, empty_node()); }
fn run(i: i64, j: i64, extra: bool) {
    var nodes: Node[>..] = [Node {}; 4];
    nodes[i].next .= nodes[j];
    nodes.resize(4);
    resize_four(nodes);
    { defer extend_to_five(nodes); }
    const count: i64 = if extra { 6 } else { 5 };
    nodes.resize(count, empty_node());
    assert(nodes.len == count);
    let target .= nodes[i].next;
    assert(target != null);
    if target { assert(target .== nodes[j]); }
}

fn main() {
    run(0, 3, false);
    run(1, 3, true);
    print("ok");
}
