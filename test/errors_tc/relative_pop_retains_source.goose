// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
fn grow_if(nodes: Node[>..]&, flag: bool) {
    if flag { nodes.push(Node {}); }
}
fn main() {
    var nodes: Node[>..] = [Node {}; 4];
    grow_if(nodes, true);
    nodes[2].next .= nodes[3];
    nodes.pop_n(2);
}
