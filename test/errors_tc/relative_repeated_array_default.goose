// error: cannot call step, which shrinks nodes: retained storage may have a self-relative link
struct Node { next: Node&<u32>? }
var nodes: Node[>..] = [Node {}, Node {}, Node {}, Node {}];
fn step() -> i64 {
    nodes.pop_n(1);
    if nodes.len == 3 { nodes[0].next .= nodes[2]; }
    return 1;
}
struct Item { n: i64 = step() }
fn main() { let items = default<Item[2]>(); }
