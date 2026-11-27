// error: bound to a writable reference
struct Node { next: Node&<u32>? }
let count = 0;

fn reset(nodes: Node[>..]&) { nodes.resize(count); }
fn change(n: i64&) { n = 1; }
fn main() {
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    reset(nodes);
    change(count);
}
