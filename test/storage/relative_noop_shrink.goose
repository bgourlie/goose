struct Node { next: Node&<u32>? }
struct List { head: Node&<u32>?, nodes: Node[>..] }
const ZERO = 0;
const ALSO_ZERO = ZERO + 0;

fn keep(nodes: Node[>..]&) {
    nodes.pop_n(0);
    nodes.resize(nodes.len);
    defer { nodes.pop_n(ALSO_ZERO); }
}

fn limited_pair() -> Node[..] {
    var nodes: Node[..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    nodes.pop_n(ALSO_ZERO);
    return nodes;
}

fn trim_then_link(nodes: Node[>..]&) {
    nodes.pop_n(1);
    nodes[0].next .= nodes[1];
    keep(nodes);
}

fn empty(nodes: Node[>..]&) {
    keep(nodes);
    nodes.pop_n(nodes.len);
    keep(nodes);
}

fn through_mutable_ref() {
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    var alias .= nodes;
    alias.resize(alias.len);
    assert(nodes.len == 2 && nodes[0].next .== nodes[1]);
    alias.pop_n(alias.len);
    assert(nodes.len == 0);
}

fn unlink_then_trim(list: List&) {
    list.nodes.resize(list.nodes.len);
    list.head .= null;
    list.nodes.pop_n(1);
}

var shared: Node[>..] = [Node {}, Node {}];
export fn keep_shared() { shared.resize(shared.len); }

fn main() {
    through_mutable_ref();
    let pair: Node[] = limited_pair();
    assert(pair.len == 2 && pair[0].next .== pair[1]);
    var nodes: Node[>..] = [Node {}, Node {}, Node {}];
    trim_then_link(nodes);
    nodes.pop_n(0);
    nodes.resize(nodes.len);
    keep(nodes);
    assert(nodes.len == 2 && nodes[0].next .== nodes[1]);
    empty(nodes);
    assert(nodes.len == 0);
    var list = List { nodes: [Node {}] };
    list.head .= list.nodes[0];
    unlink_then_trim(list);
    assert(list.head == null && list.nodes.len == 0);
    shared[0].next .= shared[1];
    keep_shared();
    assert(shared.len == 2 && shared[0].next .== shared[1]);
    print("ok");
}
