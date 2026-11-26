// error: cannot pop_n nodes: retained storage may have a self-relative link
struct Node { next: Node&<u32>? }
var nodes: Node[>..] = [];
fn reset() -> i64 { nodes.clear(); return 0; }
struct Item { n: i64 = reset() }
fn main() {
    reusable[] var pool: Item[>..] = [];
    let pair = pool.alloc_slice(2);
    nodes = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    let one = pool.realloc_slice(pair, 1);
    nodes.pop_n(1);
}
