struct Node { next: Node&<u32>? }
struct Reset {}
var nodes: Node[>..] = [];

fn format(out: u8[>..]&, value: Reset) {
    nodes.clear();
    out.append("reset");
}

fn main() {
    nodes.push(Node {});
    nodes.push(Node {});
    nodes[0].next .= nodes[1];
    print(Reset {});
    nodes.push(Node {});
    nodes.pop_n(1);
    assert(nodes.len == 0);
}
