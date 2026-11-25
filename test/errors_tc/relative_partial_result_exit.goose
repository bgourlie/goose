// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>?, n: i64 }
fn stop() -> i64 { return from install; }
fn linked(other: Node&) -> Node { Node { next: other, n: stop() } }
fn forward(other: Node&) -> Node { return linked(other); }
fn install(nodes: Node[>..]&) { nodes[0] = forward(nodes[1]); }
fn main() {
    var nodes: Node[>..] = [Node { n: 1 }, Node { n: 2 }];
    install(nodes);
    nodes.pop_n(1);
}
