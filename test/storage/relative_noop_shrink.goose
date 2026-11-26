struct Node { next: Node&<u32>? }
struct List { head: Node&<u32>?, nodes: Node[>..] }
struct Cells { head: i64&<u32>?, data: i64[>..] }
const ZERO = 0;
const ALSO_ZERO = ZERO + 0;
let zero_count = 0;
let other_zero = 0;
let unused_zero = 0;

fn keep_named(nodes: Node[>..]&) {
    nodes.pop_n(zero_count);
    nodes.pop_n(other_zero);
}

fn pop_unlinked(nodes: Node[>..]&) { nodes.pop_n(unused_zero); }
fn change(count: i64&) { count = 1; }

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
export fn pop_shared() { shared.pop_n(zero_count); }

fn main() {
    var unlinked: Node[>..] = [Node {}];
    pop_unlinked(unlinked);
    change(unused_zero);
    pop_unlinked(unlinked);
    assert(unlinked.len == 0);
    var cells = Cells { data: [1, 2] };
    cells.head .= cells.data[1];
    cells.data.pop_n(zero_count);
    cells.data.resize(cells.data.len, 0);
    cells.data.resize(cells.data.len, cells.data[0] + 1);
    assert(cells.head .== cells.data[1]);
    through_mutable_ref();
    let pair: Node[] = limited_pair();
    assert(pair.len == 2 && pair[0].next .== pair[1]);
    var nodes: Node[>..] = [Node {}, Node {}, Node {}];
    trim_then_link(nodes);
    keep_named(nodes);
    nodes.pop_n(zero_count);
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
    pop_shared();
    assert(shared.len == 2 && shared[0].next .== shared[1]);
    print("ok");
}
