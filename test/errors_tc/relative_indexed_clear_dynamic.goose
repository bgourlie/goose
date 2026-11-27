// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
const index: i64 = 0;

fn trim(index: i64) {
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    nodes[index].next .= null;
    nodes.pop_n(1);
}

fn main() { trim(1); }
