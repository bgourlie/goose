// error: retained storage may have a self-relative link to a removed element
struct Node { prev: Node&<u32>, next: Node&<u32>? }

fn link_back(n: Node&) { n.prev.next .= n; }

fn main() {
    var nodes: Node[>..] = [];
    nodes.push(Node { prev: self });
    nodes.push(Node { prev: nodes[0] });
    link_back(nodes[1]);
    nodes.pop_n(1);
}
