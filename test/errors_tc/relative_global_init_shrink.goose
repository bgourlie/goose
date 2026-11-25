// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
fn build() -> Node[] {
    var nodes: Node[] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    return nodes;
}
var nodes: Node[>..] = build();
fn trim() { nodes.pop_n(1); }
fn main() { trim(); }
