struct Node { next: Node&<u32>? }
struct List { head: Node, nodes: Node[>..] }

fn clear_array(nodes: Node[>..]&) {
    fn reset() { nodes.clear(); }
    reset();
}

fn clear_optional(nodes: Node[>..]&?, nested: bool) {
    assert(nodes);
    fn reset() { nodes.clear(); }
    if nested { reset(); } else { nodes.clear(); }
}

fn clear_field(list: List&, direct: bool) {
    let alias: List&;
    alias .= list;
    fn reset() { alias.nodes.clear(); }
    fn forward() { reset(); }
    if direct { list.nodes.clear(); } else { forward(); }
}

fn connect(n: Node&, target: Node&) { n.next .= target; }

fn clear_indexed(i: i64, helper_write: bool) {
    var nodes: Node[>..] = [Node {}, Node {}, Node {}];
    fn reset() { nodes[i].next .= null; }
    fn forward() { reset(); }
    if helper_write { connect(nodes[i], nodes[2]); }
    else { nodes[i].next .= nodes[2]; }
    forward();
    nodes.pop_n(1);
    assert(nodes.len == 2 && nodes[i].next == null);
}

fn main() {
    clear_indexed(0, false);
    clear_indexed(1, true);
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    clear_array(nodes);
    nodes.push(Node {});
    nodes.pop_n(1);
    assert(nodes.len == 0);
    for nested in [false, true] {
        nodes.push(Node {});
        nodes.push(Node {});
        nodes[0].next .= nodes[1];
        clear_optional(nodes, nested);
        nodes.push(Node {});
        nodes.pop_n(1);
        assert(nodes.len == 0);
    }

    var list = List { head: Node {}, nodes: [] };
    for direct in [false, true] {
        list.nodes.push(Node {});
        list.nodes.push(Node {});
        list.nodes[0].next .= list.nodes[1];
        clear_field(list, direct);
        list.nodes.push(Node {});
        list.nodes.pop_n(1);
        assert(list.nodes.len == 0 && list.head.next == null);
    }
    print("ok");
}
