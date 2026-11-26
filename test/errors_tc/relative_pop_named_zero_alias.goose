// error: bound to a writable reference
struct Node { next: Node&<u32>? }
let zero_count = 0;

fn change(count: i64&) { count = 1; }
fn keep(nodes: Node[>..]&) { nodes.pop_n(zero_count); }
fn main() {
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    keep(nodes);
    change(zero_count);
}
