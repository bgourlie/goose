// error: defer body writes through an alias to nodes, which build returns by name
struct Node { next: Node&<u32>? }
fn build() -> Node[] {
    var nodes: Node[] = [Node {}, Node {}];
    let alias .= nodes;
    defer { alias[0].next .= alias[1]; }
    return nodes;
}
fn main() {
    var nodes: Node[>..] = build();
    nodes.pop_n(1);
}
