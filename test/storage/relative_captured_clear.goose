struct Node { next: Node&<u32>? }
struct List { head: Node, nodes: Node[>..] }

fn clear_array(nodes: Node[>..]&) {
    fn reset() { nodes.clear(); }
    reset();
}

fn clear_field(list: List&, direct: bool) {
    let alias: List&;
    alias .= list;
    fn reset() { alias.nodes.clear(); }
    fn forward() { reset(); }
    if direct { list.nodes.clear(); } else { forward(); }
}

fn main() {
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    clear_array(nodes);
    nodes.push(Node {});
    nodes.pop_n(1);
    assert(nodes.len == 0);

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
