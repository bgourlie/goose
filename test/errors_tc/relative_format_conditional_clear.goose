// error: cannot pop_n nodes: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
struct Reset {}
var nodes: Node[>..] = [];

fn format(out: u8[>..]&, value: Reset) { nodes.clear(); }

fn main() {
    nodes.push(Node {});
    nodes.push(Node {});
    nodes[0].next .= nodes[1];
    var resets: Reset[>..] = [];
    print(resets);
    nodes.pop_n(1);
}
