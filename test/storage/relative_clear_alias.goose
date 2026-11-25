struct Node { next: Node&<u32>? }

fn clear(nodes: Node[>..]&) { nodes.clear(); }

fn clear_alias(nodes: Node[>..]&, direct: bool) {
    let alias .= nodes;
    let another .= alias;
    if direct { nodes.clear(); } else { another.clear(); }
}

fn main() {
    var nodes: Node[>..] = [Node {}, Node {}];
    var other: Node[>..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    other[0].next .= other[1];
    var alias .= nodes;
    alias.clear();
    alias .= other;
    nodes.push(Node {});
    nodes.pop_n(1);
    assert(nodes.len == 0 && alias[0].next .== other[1]);

    var other_alias .= other;
    clear(other_alias);
    other.push(Node {});
    other.pop_n(1);
    assert(other.len == 0);
    for direct in [false, true] {
        nodes.push(Node {});
        nodes.push(Node {});
        nodes[0].next .= nodes[1];
        clear_alias(nodes, direct);
        nodes.push(Node {});
        nodes.pop_n(1);
        assert(nodes.len == 0);
    }
    print("ok");
}
