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

enum Action { Link, Pop }

fn reset(nodes: Node[>..]&) -> i64 {
    nodes.clear();
    nodes.push(Node { n: 11 });
    return 1;
}

fn reset(action: Action.Link, nodes: Node[>..]&) { nodes.clear(); }
fn reset(action: Action.Pop, nodes: Node[>..]&) { nodes.resize(0); }
fn edit(action: Action.Link, nodes: Node[>..]&) { nodes[0].next .= nodes[1]; }
fn edit(action: Action.Pop, nodes: Node[>..]&) { nodes.pop_n(1); }

fn alternatives(action: Action, first: bool) {
    var nodes: Node[>..] = [Node { n: 0 }, Node { n: 0 }];
    edit(action, nodes);
    reset(action, nodes);
    nodes.push(Node { n: 7 });
    assert(nodes.pop().n == 7);

    nodes.push(Node { n: 0 });
    nodes.push(Node { n: 0 });
    if first { nodes.clear(); }
    else { nodes[0].next .= nodes[1]; nodes.clear(); }
    nodes.push(Node { n: 8 });
    assert(nodes.pop().n == 8);
}

var global_nodes: Node[>..] = [];

fn global_clear() {
    global_nodes.push(Node { n: 0 });
    global_nodes.push(Node { n: 0 });
    global_nodes[0].next .= global_nodes[1];
    global_nodes.clear();
    global_nodes.push(Node { n: 9 });
    assert(global_nodes.pop().n == 9);
}

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
    list.nodes.push(Node { n: 0 });
    list.nodes.push(Node { n: 0 });
    list.nodes[0].next .= list.nodes[1];
    list.nodes.clear();
    assert(list.nodes.len == 0);

    source.push(Node { n: 0 });
    source.push(Node { n: 0 });
    source[0].next .= source[1];
    source.resize(reset(source));
    assert(source.len == 1 && source[0].n == 11);
    alternatives(Action.Link, true);
    alternatives(Action.Pop, false);
    global_clear();
    print("ok");
}
