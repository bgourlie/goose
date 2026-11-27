struct Node { next: Node&<u32>? }
const FIRST: i64 = 0;

fn clear_link(node: Node&) { node.next .= null; }

fn main() {
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    nodes[FIRST].next .= null;
    nodes.pop_n(1);
    assert(nodes.len == 1 && nodes[0].next == null);

    nodes.push(Node {});
    nodes[0].next .= nodes[1];
    clear_link(nodes[1 - 1]);
    nodes.pop_n(1);
    assert(nodes.len == 1 && nodes[0].next == null);

    nodes.push(Node {});
    nodes[0].next .= nodes[1];
    const for <K> in [FIRST] { nodes[K] = Node {}; }
    nodes.pop_n(1);
    assert(nodes.len == 1 && nodes[0].next == null);
    print("ok");
}
