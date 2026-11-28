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

fn append_node(nodes: Node[>..]&) { nodes.push(Node {}); }
fn pop_node(nodes: Node[>..]&) { nodes.pop(); }
fn pop_pair(nodes: Node[>..]&) { pop_node(nodes); pop_node(nodes); }

struct NodeList { nodes: Node[>..] }
fn append_pair(list: NodeList&, early: bool) {
    defer { append_node(list.nodes); }
    fn leave() { append_node(list.nodes); return from append_pair; }
    if early { leave(); }
    append_node(list.nodes);
}

fn keep_link_across_calls(early: bool) {
    var list = NodeList { nodes: [Node {}, Node {}] };
    let nodes .= list.nodes;
    nodes[0].next .= nodes[1];
    append_node(nodes);
    nodes.pop();
    nodes.push(Node {});
    pop_node(nodes);
    append_pair(list, early);
    pop_pair(nodes);
    assert(nodes.len == 2 && nodes[0].next .== nodes[1]);
}

fn push_both(a: Node[>..]&, b: Node[>..]&) { a.push(Node {}); b.push(Node {}); }
fn trim_both(a: Node[>..]&, b: Node[>..]&) { a.pop(); b.pop(); }
fn trim_and_clear(a: Node[>..]&) { a.pop(); a.clear(); }
fn captured_trim(a: Node[>..]&) {
    fn trim() { a.pop(); }
    trim();
}

fn append_alias(list: NodeList&, nodes: Node[>..]&) {
    list.nodes.push(Node {});
    nodes.push(Node {});
}

fn link_and_trim(a: Node[>..]&, dst: Node&, src: Node&) { dst.next .= src; a.pop(); }

fn trim_one_path(nodes: Node[>..]&, early: bool) {
    fn leave() { if early { nodes.pop(); return from trim_one_path; } }
    leave();
    nodes.pop();
}

fn caller_suffixes() {
    var a: Node[>..] = [Node {}, Node {}];
    var b: Node[>..] = [Node {}, Node {}];
    a[0].next .= a[1];
    b[0].next .= b[1];
    push_both(a, a);
    trim_both(a, a);
    push_both(a, b);
    trim_both(a, b);
    fn captured_push(nodes: Node[>..]&) { a.push(Node {}); nodes.push(Node {}); }
    captured_push(a);
    trim_one_path(a, true);
    trim_one_path(a, false);
    var list = NodeList { nodes: [Node {}, Node {}] };
    list.nodes[0].next .= list.nodes[1];
    append_alias(list, list.nodes);
    list.nodes.pop_n(2);
    a.push(Node {});
    link_and_trim(a, b[0], b[1]);
    a.push(Node {});
    captured_trim(a);
    assert(a.len == 2 && a[0].next .== a[1] && b.len == 2 && b[0].next .== b[1]);
    assert(list.nodes.len == 2 && list.nodes[0].next .== list.nodes[1]);
    a.push(Node {});
    trim_and_clear(a);
    assert(a.len == 0);
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

fn deferred_new_slots(flag: bool) {
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    nodes.push(Node {});
    { defer { nodes.pop(); } }
    {
        defer {
            { defer { nodes.pop_n(2); } }
            if flag { nodes.push(Node {}); } else { nodes.push(Node {}); }
        }
        nodes.append([Node {}, Node {}]);
    }
    nodes.pop();
    {
        defer { nodes.pop_n(2); }
        defer { nodes.push(Node {}); }
        nodes.push(Node {});
    }
    nodes.append([Node {}, Node {}]);
    { defer { if flag { nodes.pop(); } } }
    nodes.pop();
    nodes.push(Node {});
    { defer { if flag { nodes[0].next .= nodes[1]; nodes.push(Node {}); } } }
    nodes.pop();
    assert(nodes.len == 3);
    assert(nodes[0].next .== nodes[1]);
}

struct Holder { value: i64&? }

fn twice_on_exit<F>() { defer { for i in 2 { F(); } } }
struct ArrayRef { items: i64[>..]& }
struct Indirect { view: ArrayRef& }
fn pop_through_holder(holder: Indirect&) { holder.view.items.pop(); }

fn last_use_before_deferred_pop() {
    var xs: i64[>..] = [1, 2];
    var holder = Holder {};
    defer { xs.pop(); }
    xs.push(3);
    holder.value .= xs[0];
    assert(holder.value .== xs[0]);
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

fn push_number(list: NumberList&) { list.values.push(33); }
fn pop_number(list: NumberList&) { list.values.pop(); }

fn extend() {
    var list = NumberList { values: [11, 22] };
    list.focus .= list.values[1];
    push_number(list);
    pop_number(list);
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
    keep_link_across_calls(false);
    keep_link_across_calls(true);
    caller_suffixes();
    keep_old_link(1);
    deferred_new_slots(false);
    deferred_new_slots(true);
    last_use_before_deferred_pop();
    twice_on_exit() {
        var local: i64[>..] = [1, 2];
        var view = ArrayRef { items: local };
        var holder = Indirect { view: view };
        pop_through_holder(holder);
        local.pop();
    };
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
