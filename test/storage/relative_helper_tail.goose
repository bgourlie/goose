struct Node { next: Node&<u32>? }
struct List { head: Node, nodes: Node[>..] }

fn link(src: Node&, dst: Node&) { dst.next .= src; }
fn forward(dst: Node&, src: Node&) {
    let alias .= dst;
    link(src, alias);
}

fn link_view(view: Node[:], target: Node&) {
    for &n in view { n.next .= target; }
}
fn window(view: Node[:]) -> Node[:] { view[0..] }

fn slices(whole: bool) {
    var list = List { head: Node {}, nodes: [Node {}, Node {}] };
    for &n in list.nodes[0..] { n.next .= list.head; }
    list.nodes.clear();
    list.nodes.push(Node {});
    {
        let view = if whole { list.nodes[..] } else { list.nodes[0..1] };
        view[0..][0].next .= list.head;
        assert(view[0].next .== list.head);
        link_view(window(view), list.head);
    }
    list.nodes.clear();
    list.nodes.push(Node {});
    link_view(list.nodes, list.head);
    list.nodes.clear();
}

fn main() {
    slices(true);
    slices(false);
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
    {
        let added .= list.nodes.push(Node {});
        added.next .= list.head;
        assert(added.next .== list.head);
    }
    list.nodes.clear();
    assert(list.nodes.len == 0 && list.head.next == null);
    print("ok");
}
