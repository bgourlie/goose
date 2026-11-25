struct Node { next: Node&<u32>? }
struct List { head: Node, nodes: Node[>..] }

fn clear(nodes: Node[>..]&, direct: bool) {
    let alias: Node[>..]&;
    if direct {
        alias .= nodes;
    } else {
        let same .= nodes;
        alias .= same;
    }
    alias.clear();
}

fn link(list: List&, first: bool) {
    let target: Node&;
    if first { target .= list.nodes[0]; } else { target .= list.nodes[1]; }
    target.next .= list.head;
}

fn clear_after_nested_binding(nodes: Node[>..]&, first: bool, early: bool) {
    let alias: Node[>..]&;
    fn bind() {
        fn choose() {
            alias .= nodes;
            if early { return from bind; }
        }
        if first { choose(); } else { choose(); }
    }
    bind();
    alias.clear();
}

fn main() {
    var nodes: Node[>..] = [];
    for direct in [true, false] {
        nodes.push(Node {});
        nodes.push(Node {});
        nodes[0].next .= nodes[1];
        clear(nodes, direct);
        nodes.push(Node {});
        nodes.pop_n(1);
        assert(nodes.len == 0);
        nodes.push(Node {});
        nodes.push(Node {});
        nodes[0].next .= nodes[1];
        clear_after_nested_binding(nodes, direct, !direct);
        nodes.push(Node {});
        nodes.pop_n(1);
        assert(nodes.len == 0);
    }
    var list = List { head: Node {}, nodes: [Node {}, Node {}] };
    link(list, false);
    assert(list.nodes[1].next .== list.head);
    list.nodes.clear();
    print("ok");
}
