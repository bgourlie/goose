struct Node { next: Node&<u32>?, owner: Node[]&<u32>? }
struct List { first: Node&<u32>?, nodes: Node[>..] }

fn linked() -> Node[] {
    var nodes: Node[] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    return nodes;
}

fn growable() -> Node[>..] { linked() }

fn as_limited() -> Node[..] { linked() }

fn keep_length(nodes: Node[..]&) {
    nodes.pop_n(0);
    nodes.resize(nodes.len);
}

fn limited_pair() -> Node[..] {
    var nodes: Node[..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    keep_length(nodes);
    return nodes;
}

fn forward_pair() -> Node[..] { limited_pair() }

fn grown_pair() -> Node[..] {
    var nodes: Node[..] = [..4];
    nodes.push(Node {});
    nodes.push(Node {});
    nodes[0].next .= nodes[1];
    return nodes;
}

fn header_link() -> Node[] {
    var nodes: Node[] = [Node {}];
    nodes[0].owner .= nodes;
    return nodes;
}

fn make_list() -> List { List { nodes: growable() } }

struct Entry { field: i64[1], inner: i64[1]&<u32>?, owner: Entry[]&<u32>? }

fn entries() -> Entry[] {
    var xs: Entry[] = [Entry { field: [42] }];
    xs[0].inner .= xs[0].field;
    return xs;
}

struct Bucket { value: i64 = 7, owner: Bucket&<u32>?, selected: i64&<u32>? }
fn forward(buckets: Bucket[>..]&) -> Bucket[>..]& { buckets }

fn same_element(i: i64) {
    var nodes: Bucket[>..] = [Bucket {}, Bucket {}];
    nodes[i].owner .= nodes[i];
    nodes[i].selected .= nodes[i].value;
    let other .= nodes;
    nodes[i].owner .= other[i];
    other[i].selected .= forward(forward(nodes))[i].value;
    nodes.pop_n(1);
    if i == 0 { assert(nodes[0].owner .== nodes[0] && nodes[0].selected .== nodes[0].value); }
    else { assert(nodes[0].owner == null); }
}

fn same_constant_element() {
    var nodes: Bucket[>..] = [Bucket {}, Bucket {}];
    var calls = 0;
    fn view() -> Bucket[>..]& { calls += 1; return nodes; }
    const first: i64 = 0;
    nodes[first].owner .= view()[0];
    nodes.pop_n(1);
    assert(calls == 1 && nodes[0].owner .== nodes[0]);
}

fn link_to_first(i: i64) {
    var nodes: Bucket[>..] = [Bucket {}, Bucket {}, Bucket {}];
    let alias .= nodes;
    const first: i64 = 0;
    nodes[i].owner .= alias[first];
    nodes[i].selected .= nodes[0].value;
    nodes.pop_n(1);
    if i < nodes.len {
        assert(nodes[i].owner .== nodes[0] && nodes[i].selected .== nodes[0].value);
    } else { assert(nodes[0].owner == null && nodes[1].owner == null); }
}

fn backward_link() {
    var nodes: Node[>..] = [Node {}, Node {}, Node {}];
    let alias .= nodes;
    nodes[1].next .= alias[0];
    nodes.pop_n(1);
    assert(nodes[1].next .== nodes[0]);
    nodes.pop_n(1);
    assert(nodes.len == 1);
}

fn appended_link(i: i64) {
    var nodes: Node[>..] = [Node {}, Node {}];
    let previous .= nodes[i];
    fn append() {
        let current .= nodes.push(Node {});
        let alias = &current;
        let target .= previous;
        alias.next .= target;
        nodes.push(Node {}).next .= previous;
        assert(current.next .== previous && nodes[3].next .== previous);
    }
    append();
    nodes.pop_n(1);
    assert(nodes.len == 3 && nodes[2].next .== nodes[i]);
}

fn pushed_link_to_first() {
    var nodes: Node[>..] = [Node {}];
    nodes.push(Node {}).next .= nodes[0];
    {
        let added .= nodes.push(Node {});
        let alias .= added;
        alias.next .= nodes[0];
    }
    nodes.pop_n(1);
    assert(nodes[1].next .== nodes[0]);
    nodes.pop_n(1);
    assert(nodes.len == 1);
}

fn remove_new_slots(nodes: Node[>..]&, flag: bool) {
    if flag { nodes.push(Node {}); }
    else { nodes.push(Node {}); }
    nodes.push(Node {});
    nodes.pop();
    nodes.pop_n(1);
    nodes.append([Node {}, Node {}]);
    nodes.pop_n(2);
}

fn keep_old_link(i: i64) {
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes[0].next .= nodes[i];
    nodes.push(Node {});
    nodes.pop_n(1);
    remove_new_slots(nodes, true);
    remove_new_slots(nodes, false);
    assert(nodes.len == 2 && nodes[0].next .== nodes[i]);
}

fn fixed_append_source() {
    var list = NumberList { values: [11, 22] };
    list.focus .= list.values[1];
    let extra: i64[2] = [33, 44];
    list.values.append(extra);
    list.values.pop_n(2);
    assert(list.values.len == 2 && list.focus .== list.values[1]);
    var xs: i64[>..] = [];
    xs.append([1; 32]);
    while xs.len > 0 { xs.pop(); }
    assert(xs.len == 0);
}

const TWO = 1 + 1;
struct NumberList { focus: i64&<u32>?, values: i64[>..] }

fn extend() {
    var list = NumberList { values: [11, 22] };
    list.focus .= list.values[1];
    let alias .= list;
    alias.values.resize(list.values.len + 1, 33);
    const extra: i64 = 2;
    list.values.resize(extra + alias.values.len, 44);
    const runtime: i64 = list.values.len;
    list.values.resize(list.values.len + runtime, 55);
    let delta = 1;
    list.values.resize(delta + list.values.len, 66);
    list.values.resize(list.values.len + list.values.len, 77);
    let two = block { break TWO; };
    list.values.resize(list.values.len + two, 88);
    assert(list.values.len == 24 && list.values[2] == 33 && list.focus .== list.values[1]);
}

fn fill_count(calls: i64&) -> i64 { calls += 1; return calls; }

fn extend_with_other(list: NumberList&, other: i64[>..]&) {
    fn fill() -> i64 { other.push(17); return 33; }
    list.values.resize(list.values.len + 1, fill());
}

fn limited_with_fill() -> Node[..] {
    var nodes: Node[..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    var other: i64[>..] = [];
    var limited: i64[..2] = [1];
    fn fill() -> Node {
        other.push(17);
        other.clear();
        limited = [18, 19];
        return Node {};
    }
    nodes.resize(nodes.len, fill());
    return nodes;
}

fn resize_with_fill() {
    var list = NumberList { values: [11, 22] };
    list.focus .= list.values[1];
    var calls = 0;
    list.values.resize(list.values.len, fill_count(calls));
    var other: i64[>..] = [];
    extend_with_other(list, other);
    let limited: Node[] = limited_with_fill();
    assert(limited[0].next .== limited[1]);
    assert(calls == 1 && other.len == 1 && list.values[2] == 33 && list.focus .== list.values[1]);
}

fn clear_node(node: Node&) { node.next .= null; }

fn clear_link(i: i64) {
    var nodes: Node[>..] = [Node {}, Node {}, Node {}];
    nodes[i].next .= nodes[2];
    let alias .= nodes;
    assert(alias[i].next .== nodes[2]);
    alias[i].next .= null;
    nodes[i] = Node { next: nodes[2] };
    clear_node(nodes[i]);
    nodes[i].next .= { nodes[2] };
    { defer alias[i].next .= null; }
    nodes.pop_n(1);
    assert(nodes[i].next == null);
    let change .= i;
    change = 1;
}

fn deferred_clear(i: i64) {
    var nodes: Node[>..] = [Node {}, Node {}, Node {}];
    nodes[i].next .= nodes[2];
    {
        defer {
            nodes[i].next .= null;
            let change .= i;
            change = 1;
        }
    }
    nodes.pop_n(1);
    assert(nodes[0].next == null);
}

fn main() {
    deferred_clear(0);
    clear_link(0);
    clear_link(1);
    resize_with_fill();
    extend();
    appended_link(1);
    pushed_link_to_first();
    keep_old_link(1);
    fixed_append_source();
    backward_link();
    link_to_first(0);
    link_to_first(1);
    link_to_first(2);
    same_element(0);
    same_element(1);
    same_constant_element();
    let converted: Node[] = as_limited();
    assert(converted.len == 2 && converted[0].next .== converted[1]);
    let pair: Node[] = forward_pair();
    assert(pair.len == 2 && pair[0].next .== pair[1]);
    let run: Node[] = grown_pair();
    assert(run.len == 2 && run[0].next .== run[1]);
    let unchanged: Node[] = header_link();
    assert(unchanged[0].owner .== unchanged);
    var list = make_list();
    assert(list.first == null && list.nodes[0].next .== list.nodes[1]);
    list.nodes.clear();
    assert(list.nodes.len == 0);
    var grown: Entry[>..] = entries();
    assert(grown[0].inner .== grown[0].field && grown[0].owner == null);
    print("ok");
}
