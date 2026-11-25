// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
root struct Arena { nodes: Node[>..] }
fn main() {
    var outer = Arena { nodes: [Node {}, Node {}] };
    loop {
        var inner = Arena { nodes: [Node {}, Node {}] };
        inner.nodes[0].next .= inner.nodes[1];
        let alias .= outer.nodes[0];
        defer { alias.next .= outer.nodes[1]; }
        break;
    }
    outer.nodes.pop_n(1);
}
