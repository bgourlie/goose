// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>?, n: i64 }
fn stop() -> Node { return from install; }
fn make(other: Node&, early: bool) -> Node {
    return Node { next: other, n: block { if early { return stop(); } 42 } };
}
fn install(nodes: Node[>..]&, early: bool) {
    nodes[0] = make(nodes[1], early);
    nodes.clear();
    nodes.push(Node { n: 1 });
}
fn main() {
    var nodes: Node[>..] = [Node { n: 1 }, Node { n: 2 }];
    install(nodes, true);
    nodes.pop_n(1);
}
