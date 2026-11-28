// error: retained storage may have a self-relative link to a removed element
struct Node { tag: i64, next: Node&<u32>? }
fn set(nodes: Node[>..]&, i: i64&) {
    fn advance() -> i64 { i = 1; return 0; }
    nodes[i] = Node { tag: advance(), next: nodes[i] };
    nodes.pop();
}
fn main() {
    var nodes: Node[>..] = [Node { tag: 0 }; 2];
    var i = 0;
    set(nodes, i);
}
