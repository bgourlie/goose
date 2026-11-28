// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn main() {
    var other: Node[>..] = [Node {}];
    var nodes: Node[>..] = [Node {}, Node {}];
    const count = other.len;
    nodes[0].next .= nodes[1];
    nodes.pop_n(count);
}
