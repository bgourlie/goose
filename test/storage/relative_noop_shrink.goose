struct Node { next: Node&<u32>? }
struct List { head: Node&<u32>?, nodes: Node[>..] }
struct Cells { head: i64&<u32>?, data: i64[>..] }
struct Point { coords: i64[2] = [0; 2] }
struct Points { cursor: Point&<u32>?, values: Point[>..] }
const ZERO = 0;
const ALSO_ZERO = ZERO + 0;
const TYPED_ZERO: i64 = 0;
let zero_count = 0;
let other_zero = 0;
let unused_zero = 0;
let unused_limited_count = 0;
let size_source = 2;
let copied_size = size_source;

fn zero() -> i64 { 0 }
fn plus_one(n: i64) -> i64 { n + 1 }

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

fn keep_saved(nodes: Node[>..]&) {
    const size = nodes.len;
    let alias .= nodes;
    nodes.resize(nodes.len);
    alias.resize(size);
    nodes.resize(size);
    defer { nodes.resize(size); }
}

fn grow_scratch(nodes: Node[>..]&, scratch: i64[>..]&) {
    const size = nodes.len;
    scratch.push(7);
    nodes.resize(size);
}

fn keep_after_growth(nodes: Node[>..]&, scratch: Node[>..]&, later: bool) {
    const size = nodes.len;
    if later { defer { scratch.push(Node {}); } }
    if !later { scratch.push(Node {}); }
    nodes.resize(size);
}

fn forward_growth(nodes: Node[>..]&, scratch: Node[>..]&) {
    keep_after_growth(nodes, scratch, true);
    keep_after_growth(nodes, scratch, false);
    fn captured() {
        const size = nodes.len;
        scratch.push(Node {});
        nodes.resize(size);
    }
    captured();
}

fn restore_before_link(nodes: Node[>..]&, scratch: Node[>..]&) {
    const size = nodes.len;
    scratch.push(Node {});
    { defer { nodes.resize(size); } }
    nodes[0].next .= nodes[1];
    nodes.resize(size);
}

fn restore_both_counts() {
    var a: Node[>..] = [Node {}, Node {}];
    var b: Node[>..] = [Node {}, Node {}, Node {}];
    const size = a.len;
    a.push(Node {});
    { defer { a.resize(size); } }
    b.resize(size);
    a[0].next .= a[1];
    b[0].next .= b[1];
    a.resize(size);
    b.resize(size);
    assert(a.len == 2 && a[0].next .== a[1]);
    assert(b.len == 2 && b[0].next .== b[1]);
}

fn keep_copied_size() {
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes.resize(copied_size);
    nodes[0].next .= nodes[1];
    change(size_source);
    nodes.resize(copied_size);
    assert(nodes.len == 2 && nodes[0].next .== nodes[1]);
}

fn clear_twice(nodes: Node[>..]&, scratch: Node[>..]&) {
    nodes.resize(ZERO);
    scratch.push(Node {});
    scratch.push(Node {});
    scratch[0].next .= scratch[1];
    nodes.resize(ZERO);
}

fn clear_selected(flag: bool) {
    var nodes: Node[>..] = [];
    var other: Node[>..] = [];
    let scratch: Node[>..]& = if flag { nodes } else { other };
    clear_twice(nodes, scratch);
    assert(nodes.len == 0);
}

fn restore_selected(flag: bool) {
    var first: Node[>..] = [Node {}, Node {}];
    var second: Node[>..] = [];
    let scratch: Node[>..]& = if flag { first } else { second };
    restore_before_link(first, scratch);
    assert(first.len == 2 && first[0].next .== first[1]);
}

struct ScratchView { data: i64[>..]& }

fn fill_selected(view: ScratchView&, a: Cells&, b: Cells&, scratch: i64[>..]&, flag: bool) {
    let selected: Cells& = if flag { a } else { b };
    fn fill() -> i64 { scratch.push(7); return 0; }
    selected.data.resize(selected.data.len, fill());
    assert(view.data.len == scratch.len);
}

fn leave_with_growth(scratch: i64[>..]&) {
    scratch.push(8);
    return from keep_on_exit;
}

fn keep_on_exit(nodes: Node[>..]&, scratch: i64[>..]&) {
    const size = nodes.len;
    defer { nodes.resize(size); }
    leave_with_growth(scratch);
}

fn restore_measurement(cells: Cells&) {
    const size = cells.data.len;
    { defer { cells.data.resize(size, 0); } }
    cells.data.resize(size, 0);
}

fn add_nothing(cells: Cells&) {
    cells.data.append([]);
    cells.data.resize(cells.data.len, 0);
}

fn keep_after_empty_operations(cells: Cells&) {
    const size = cells.data.len;
    cells.data.append([]);
    cells.data.resize(size);
    cells.data.resize(cells.data.len, 0);
    add_nothing(cells);
    cells.data.resize(size);
}

fn keep_through_alias(nodes: Node[>..]&) {
    let other .= nodes;
    nodes.resize(other.len);
    let alias .= other;
    resize(alias, nodes.len);
}

fn forward_array(nodes: Node[>..]&) -> Node[>..]& { nodes }

fn keep_selection(first: bool) {
    var a: Node[>..] = [Node {}, Node {}];
    var b: Node[>..] = [Node {}, Node {}, Node {}];
    a[0].next .= a[1];
    b[0].next .= b[2];
    let copy: Node[>..]&;
    {
        let selected: Node[>..]& = if first { a } else { b };
        let other .= selected;
        copy .= other;
        selected.resize(copy.len);
        other.resize(selected.len);
        defer { copy.resize(selected.len); }
    }
    assert(copy.len == (if first { 2 } else { 3 }));

    let views: (Node[>..]&)[2] = [a, b];
    let from_slot .= views[if first { 0 } else { 1 }];
    let forwarded .= forward_array(from_slot);
    from_slot.resize(forwarded.len);
    assert(a.len == 2 && a[0].next .== a[1]);
    assert(b.len == 3 && b[0].next .== b[2]);
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

fn pop_saved_length(nodes: Node[>..]&) {
    let alias .= nodes;
    const n = nodes.len;
    alias.pop_n(n);
}

fn pop_after_named_resize(limit: i64) {
    var nodes: Node[>..] = [Node {}, Node {}, Node {}];
    nodes.resize(limit);
    nodes[0].next .= nodes[1];
    nodes.pop_n(limit);
    assert(nodes.len == 0);
}

fn pop_selected(first: bool) {
    var a: Node[>..] = [Node {}, Node {}];
    var b: Node[>..] = [Node {}, Node {}, Node {}];
    a[0].next .= a[1];
    b[0].next .= b[2];
    let selected: Node[>..]& = if first { a } else { b };
    const count = selected.len;
    selected.pop_n(count);
    if first { assert(a.len == 0 && b[0].next .== b[2]); }
    else { assert(b.len == 0 && a[0].next .== a[1]); }
}

fn empty_with_saved_count() {
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    pop_saved_length(nodes);
    assert(nodes.len == 0);
    nodes.push(Node {});
    nodes.push(Node {});
    nodes[0].next .= nodes[1];
    let n = nodes.len;
    { defer nodes.pop_n(n); }
    assert(nodes.len == 0);
}

fn empty_with_known_count() {
    const local: i64 = TYPED_ZERO;
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    nodes.pop_n(local);
    nodes.pop_n(TYPED_ZERO);
    assert(nodes.len == 2 && nodes[0].next .== nodes[1]);
    nodes.resize(local);
    assert(nodes.len == 0);
}

fn through_mutable_ref() {
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    let views: (Node[>..]&)[2] = [nodes, nodes];
    views[views.len - 1].resize(views[views.len - 1].len);
    var alias .= nodes;
    alias.resize(alias.len);
    assert(nodes.len == 2 && nodes[0].next .== nodes[1]);
    alias.pop_n(nodes.len);
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
    empty_with_known_count();
    empty_with_saved_count();
    pop_selected(true);
    pop_selected(false);
    pop_after_named_resize(2);
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
    keep_after_empty_operations(cells);
    restore_measurement(cells);
    var other_cells = Cells { data: [3, 4] };
    other_cells.head .= other_cells.data[1];
    var fill_scratch: i64[>..] = [];
    var view = ScratchView { data: fill_scratch };
    fill_selected(view, cells, other_cells, fill_scratch, false);
    fill_selected(view, cells, other_cells, fill_scratch, true);
    assert(cells.head .== cells.data[1] && other_cells.head .== other_cells.data[1]);
    let cell_alias .= cells;
    cells.data.resize(cell_alias.data.len, 0);
    cell_alias.data.resize(cells.data.len);
    cells.data.pop_n(zero_count);
    cells.data.resize(cells.data.len, 0);
    cells.data.resize(cells.data.len, zero());
    cells.data.resize(cells.data.len, plus_one(5));
    cells.data.resize(cells.data.len, cells.data[0] + 1);
    let n: u64 = 3;
    cells.data.resize(cells.data.len, n as i64);
    cells.data.resize(cells.data.len, if n > 0 { 1 } else { 2 });
    cells.data.resize(cells.data.len, match n { 0 => 17, _ => 34 });
    assert(cells.head .== cells.data[1]);
    let indexed: Node[] = indexed_receiver(0);
    assert(indexed.len == 2 && indexed[0].next .== indexed[1]);
    through_mutable_ref();
    keep_selection(true);
    keep_selection(false);
    let pair: Node[] = limited_pair();
    assert(pair.len == 2 && pair[0].next .== pair[1]);
    let shortened: Node[] = shortened_pair();
    assert(shortened.len == 2 && shortened[0].next .== shortened[1]);
    var nodes: Node[>..] = [Node {}, Node {}, Node {}];
    trim_then_link(nodes);
    keep_named(nodes);
    keep_saved(nodes);
    var scratch: i64[>..] = [];
    grow_scratch(nodes, scratch);
    var other_nodes: Node[>..] = [];
    forward_growth(nodes, other_nodes);
    assert(other_nodes.len == 3 && nodes[0].next .== nodes[1]);
    restore_selected(false);
    restore_selected(true);
    restore_both_counts();
    keep_copied_size();
    clear_selected(false);
    clear_selected(true);
    keep_on_exit(nodes, scratch);
    assert(scratch.len == 2);
    nodes.pop_n(zero_count);
    nodes.pop_n(0);
    nodes.resize(nodes.len);
    keep(nodes);
    let alias .= nodes;
    nodes.resize(alias.len);
    keep_through_alias(nodes);
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
