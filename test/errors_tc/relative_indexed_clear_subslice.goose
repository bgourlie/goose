// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn main() {
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    let tail = nodes[1..];
    tail[0].next .= null;
    nodes.pop_n(1);
}
