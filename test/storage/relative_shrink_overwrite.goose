struct Node { n: i64, next: Node&<u32>? }
struct List { first: Node&<u32>?, nodes: Node[>..] }

fn unlinked() -> Node[] {
    let nodes: Node[] = [Node { n: 42 }];
    return nodes;
}

fn prefix() -> Node[..] {
    var nodes: Node[..] = [Node { n: 7 }, Node { n: 8 }];
    nodes.pop_n(1);
    return nodes;
}

fn rebuild(nodes: Node[>..]&) {
    nodes[0].next .= nodes[1];
    nodes.clear();
    nodes.push(Node { n: 3 });
    nodes.push(Node { n: 4 });
    nodes.pop_n(1);
}

fn replace(list: List&) { list = List { nodes: [Node { n: 5 }] }; }

fn main() {
    var shrinkable: Node[>..<] = unlinked();
    let live: Node[] = prefix();
    assert(shrinkable[0].n == 42 && live.len == 1 && live[0].n == 7);

    var source: Node[>..] = [Node { n: 1 }, Node { n: 2 }];
    source[0].next .= source[1];
    var nodes, ok = from_bytes<Node[>..]>(source.to_bytes());
    assert(ok && nodes[0].next .== nodes[1]);
    source.resize(0);
    source.push(Node { n: 6 });
    assert(source.pop().n == 6);
    rebuild(nodes);
    assert(nodes.len == 1 && nodes[0].n == 3);
    nodes.pop_n(1);
    assert(nodes.len == 0);

    var list = List { nodes: [Node { n: 1 }, Node { n: 2 }] };
    list.first .= list.nodes[1];
    replace(list);
    assert(list.first == null && list.nodes.len == 1 && list.nodes[0].n == 5);
    list.first .= list.nodes[0];
    list.first .= null;
    list.nodes.clear();
    assert(list.nodes.len == 0);
    print("ok");
}
