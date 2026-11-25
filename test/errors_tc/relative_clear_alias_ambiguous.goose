// error: cannot pop_n nodes: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn maybe_clear(first: bool) {
    var nodes: Node[>..] = [Node {}, Node {}];
    var other: Node[>..] = [];
    nodes[0].next .= nodes[1];
    var alias .= nodes;
    if first { alias .= other; }
    alias.clear();
    nodes.pop_n(1);
}

fn main() { maybe_clear(true); }
