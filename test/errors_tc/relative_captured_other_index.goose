// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn trim(i: i64, j: i64) {
    var nodes: Node[>..] = [Node {}, Node {}, Node {}];
    fn reset() { nodes[j].next .= null; }
    nodes[i].next .= nodes[2];
    reset();
    nodes.pop_n(1);
}

fn main() { trim(0, 1); }
