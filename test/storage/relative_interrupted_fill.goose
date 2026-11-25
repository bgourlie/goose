struct Node { next: Node&<u32>?, n: i64 }
struct List { header: Node[1], nodes: Node[>..] }

fn leave() -> i64 { return from install; }
fn install(list: List&) {
    list.header = [Node { next: list.nodes[0], n: leave() }; 1];
}

fn fallback() -> i64 { return [Node { n: 7 }] from build; }
fn build(first: Node&, stop: bool) -> Node[1] {
    [if stop { Node { next: first, n: fallback() } }
     else { Node { n: 8 } }; 1]
}

fn main() {
    var list = List { header: [Node { n: 3 }], nodes: [Node { n: 2 }] };
    install(list);
    list.nodes.clear();
    assert(list.header[0].n == 3 && list.header[0].next == null);
    list.nodes.push(Node { n: 1 });
    list.header = build(list.nodes[0], true);
    assert(list.header[0].n == 7);
    list.header = build(list.nodes[0], false);
    list.nodes.clear();
    assert(list.header[0].n == 8);
    print("ok");
}
