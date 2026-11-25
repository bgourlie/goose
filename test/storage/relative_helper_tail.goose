struct Node { next: Node&<u32>? }
struct List { head: Node, nodes: Node[>..] }

fn link(src: Node&, dst: Node&) { dst.next .= src; }
fn forward(dst: Node&, src: Node&) {
    let alias .= dst;
    link(src, alias);
}

fn main() {
    var list = List { head: Node {}, nodes: [Node {}, Node {}] };
    forward(list.nodes[0], list.nodes[1]);
    assert(list.nodes[0].next .== list.nodes[1]);
    list.nodes.clear();
    assert(list.nodes.len == 0 && list.head.next == null);
    list.nodes.push(Node {});
    list.nodes.push(Node {});
    for &n, i in list.nodes { if i == 0 { n.next .= list.nodes[1]; } }
    assert(list.nodes[0].next .== list.nodes[1]);
    list.nodes.clear();
    assert(list.nodes.len == 0 && list.head.next == null);
    print("ok");
}
