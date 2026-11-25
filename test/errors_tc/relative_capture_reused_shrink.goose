// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn use(count: i64) {
    var nodes: Node[>..] = [Node {}, Node {}];
    fn trim() { nodes.pop_n(count); }
    trim();
    nodes[0].next .= nodes[1];
    trim();
}

fn main() { use(0); }
