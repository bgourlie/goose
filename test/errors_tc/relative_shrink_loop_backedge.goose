// error: cannot pop_n nodes: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn main() {
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    nodes.clear();
    nodes.push(Node {});
    nodes.push(Node {});
    for i in 2 {
        nodes.pop_n(1);
        nodes.push(Node {});
        nodes[0].next .= nodes[1];
    }
}
