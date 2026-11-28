struct Node { next: Node&<u32>? }

var nodes: Node[>..] = [Node {}; 3];
fn extend() -> i64 { nodes.push(Node {}); 1 }
let initialized = extend();

fn main() {
    nodes[2].next .= nodes[3];
    nodes.pop_n(2);
    assert(initialized == 1 && nodes.len == 2);
    print("ok");
}
