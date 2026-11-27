// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn clear(i: i64, j: i64) {
    var nodes: Node[>..] = [Node {}, Node {}, Node {}];
    nodes[i].next .= nodes[2];
    nodes[j].next .= nodes[2];
    nodes[i].next .= null;
    nodes.pop_n(1);
}

fn main() { clear(0, 1); }
