// error: cannot pop_n nodes: retained storage may have a self-relative link
struct Node { next: Node&<u32>? }
var nodes: Node[>..] = [Node {}, Node {}];
fn reset() -> i64 { nodes.clear(); return 0; }
struct Item { n: i64 = reset() }
fn main() {
    reusable[] var pool: Item[>..] = [];
    nodes[0].next .= nodes[1];
    let empty = pool.alloc_slice(0);
    nodes.pop_n(1);
}
