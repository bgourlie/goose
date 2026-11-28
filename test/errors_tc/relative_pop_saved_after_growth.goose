// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn main() {
    var nodes: Node[>..] = [Node {}, Node {}];
    const count = nodes.len;
    nodes.push(Node {});
    nodes[0].next .= nodes[2];
    nodes.pop_n(count);
}
