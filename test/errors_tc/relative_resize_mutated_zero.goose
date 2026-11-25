// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
let LENGTH = 0;
fn set_length(n: i64&) { n = 1; }

fn main() {
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    set_length(LENGTH);
    nodes.resize(LENGTH);
}
