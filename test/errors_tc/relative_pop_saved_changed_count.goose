// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn main() {
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    let count = nodes.len;
    let change .= count;
    change = 1;
    nodes.pop_n(count);
}
