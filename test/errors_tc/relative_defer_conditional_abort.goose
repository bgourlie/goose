// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn visit(stop: bool) {
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    defer { nodes.pop_n(1); }
    defer { if stop { abort("stop"); } }
}
fn main() { visit(true); }
