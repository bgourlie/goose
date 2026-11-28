// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

var nodes: Node[>..] = [Node {}; 4];
fn extend() -> i64 { nodes.push(Node {}); 1 }
let initialized = extend();

fn main() {
    nodes[2].next .= nodes[3];
    nodes.pop_n(2);
}
