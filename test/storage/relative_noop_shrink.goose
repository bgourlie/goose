struct Node { next: Node&<u32>? }
struct List { head: Node&<u32>?, nodes: Node[>..] }
struct Cells { head: i64&<u32>?, data: i64[>..] }
struct Point { coords: i64[2] = [0; 2] }
struct Points { cursor: Point&<u32>?, values: Point[>..] }
const ZERO = 0;
const ALSO_ZERO = ZERO + 0;
let zero_count = 0;
let other_zero = 0;
let unused_zero = 0;
let unused_limited_count = 0;

fn zero() -> i64 { 0 }

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
    nodes.pop_n(zero_count);
    return nodes;
}

fn pop_limited(nodes: Node[..]&) { nodes.pop_n(other_zero); }

fn indexed_receiver(i: i64) -> Node[..] {
    var nodes: Node[..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    var views: (Node[..]&)[2] = [nodes, nodes];
    (&nodes).resize((&nodes).len);
    resize(&nodes, nodes.len);
    views[0].resize(views[0].len);
    views[i].resize(views[i].len);
    views[i + 1].resize(views[i + 1].len);
    let offsets: i64[..] = [0, 1];
    views[offsets.cap - 1].resize(views[offsets.cap - 1].len);
    return nodes;
}

fn shortened_pair() -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    nodes.pop_n(1);
    let last .= nodes[1];
    pop_limited(nodes);
    nodes[0].next .= last;
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
    let views: (Node[>..]&)[2] = [nodes, nodes];
    views[views.len - 1].resize(views[views.len - 1].len);
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
    var points = Points { values: [Point { coords: [4, 2] }] };
    points.cursor .= points.values[0];
    points.values.resize(points.values.len, Point { coords: [7, 8] });
    points.values.resize(points.values.len, Point {});
    points.values.resize(points.values.len, default<Point>());
    assert(points.cursor .== points.values[0]);
    var limited: Node[..] = [Node {}, Node {}];
    limited[0].next .= limited[1];
    limited.pop_n(unused_limited_count);
    assert(limited.len == 2);
    change(unused_limited_count);
    var unlinked: Node[>..] = [Node {}];
    pop_unlinked(unlinked);
    change(unused_zero);
    pop_unlinked(unlinked);
    assert(unlinked.len == 0);
    var cells = Cells { data: [1, 2] };
    cells.head .= cells.data[1];
    cells.data.pop_n(zero_count);
    cells.data.resize(cells.data.len, 0);
    cells.data.resize(cells.data.len, zero());
    cells.data.resize(cells.data.len, cells.data[0] + 1);
    let n: u64 = 3;
    cells.data.resize(cells.data.len, n as i64);
    cells.data.resize(cells.data.len, if n > 0 { 1 } else { 2 });
    cells.data.resize(cells.data.len, match n { 0 => 17, _ => 34 });
    assert(cells.head .== cells.data[1]);
    let indexed: Node[] = indexed_receiver(0);
    assert(indexed.len == 2 && indexed[0].next .== indexed[1]);
    through_mutable_ref();
    let pair: Node[] = limited_pair();
    assert(pair.len == 2 && pair[0].next .== pair[1]);
    let shortened: Node[] = shortened_pair();
    assert(shortened.len == 2 && shortened[0].next .== shortened[1]);
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
