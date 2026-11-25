struct Node { next: Node&<u32>? }
struct List { head: Node, nodes: Node[>..] }

fn link(dst: Node&, src: Node&) { dst.next .= src; }
fn link_optional(dst: Node&?, src: Node&) { if dst { dst.next .= src; } }

fn choose(list: List&, first: bool) {
    let target: Node& = if first { list.nodes[0] } else { list.nodes[1] };
    target.next .= list.head;
}

fn delayed(list: List&, first: bool) {
    let target: Node&;
    target .= if first { list.nodes[0] } else { list.nodes[1] };
    link(target, list.head);
}

fn optional(list: List&, first: bool) {
    let direct: Node&? = list.nodes[0];
    if direct { direct.next .= list.head; }
    let maybe: Node&? = block {
        if first { break null; }
        list.nodes[1]
    };
    link_optional(maybe, list.head);
}

fn bind_optional(list: List&, empty: bool) {
    let direct: Node&?;
    if empty { direct .= null; } else { direct .= list.nodes[0]; }
    if direct { direct.next .= list.head; }

    let captured: Node&?;
    fn bind() {
        if empty { captured .= null; return; }
        captured .= list.nodes[1];
    }
    bind();
    if captured { captured.next .= list.head; }
}

fn clear(nodes: Node[>..]&, direct: bool) {
    let alias .= nodes;
    let same: Node[>..]& = if direct { nodes } else { alias };
    same.clear();
}

fn main() {
    var list = List { head: Node {}, nodes: [Node {}, Node {}] };
    for first in [true, false] {
        choose(list, first);
        delayed(list, !first);
        link(if first { list.nodes[0] } else { list.nodes[1] }, list.head);
        assert(list.nodes[0].next .== list.head && list.nodes[1].next .== list.head);
        list.nodes.clear();
        list.nodes.push(Node {});
        list.nodes.push(Node {});
        optional(list, first);
        assert(list.nodes[0].next .== list.head);
        if first { assert(list.nodes[1].next == null); }
        else { assert(list.nodes[1].next .== list.head); }
        list.nodes.clear();
        list.nodes.push(Node {});
        list.nodes.push(Node {});
        bind_optional(list, first);
        if first { assert(list.nodes[0].next == null && list.nodes[1].next == null); }
        else { assert(list.nodes[0].next .== list.head && list.nodes[1].next .== list.head); }
        list.nodes.clear();
        list.nodes.push(Node {});
        list.nodes.push(Node {});
    }
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    clear(nodes, false);
    nodes.push(Node {});
    nodes.pop_n(1);
    assert(nodes.len == 0);
    print("ok");
}
