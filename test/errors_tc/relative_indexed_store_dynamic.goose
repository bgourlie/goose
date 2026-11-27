// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn trim(index: i64) {
    var nodes: Node[>..] = [Node {}, Node {}, Node {}];
    nodes[index].next .= nodes[2];
    nodes[0].next .= null;
    nodes.pop_n(1);
}

fn main() { trim(1); }
