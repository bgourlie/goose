struct Node { refs: (Node&<u32>)[..2] }
struct List { head: Node, first: Node&<u32>?, links: (Node&<u32>?)[2], nodes: Node[>..] }
struct Group { headers: Node[2], nodes: Node[>..] }
root struct State { list: List, other: i64 }

fn add(node: Node&, target: Node&) { node.refs.push(target); }
fn link(st: State&) { st.list.first .= st.list.nodes[0]; }
fn unlink(st: State&) { st.list.first .= null; }

fn nested_arrays() {
    var xs = List { head: Node { refs: [] }, links: [null, null], nodes: [Node { refs: [] }] };
    xs.nodes[0].refs.push(xs.head);
    assert(xs.nodes[0].refs[0] .== xs.head);
    xs.nodes.clear();
    xs.nodes.push(Node { refs: [] });
    add(xs.head, xs.nodes[0]);
    xs.head.refs = [];
    add(xs.nodes[0], xs.head);
    xs.nodes.clear();
}

fn indexed_field(i: i64) {
    var xs = List { head: Node { refs: [] }, links: [null, null], nodes: [Node { refs: [] }] };
    xs.links[i] .= xs.nodes[0];
    assert(xs.links[i] .== xs.nodes[0]);
    xs.links = [null, null];
    xs.nodes.clear();

    var group = Group { headers: [Node { refs: [] }, Node { refs: [] }], nodes: [Node { refs: [] }] };
    {
        let header .= group.headers[i];
        add(header, group.nodes[0]);
    }
    group.headers = [Node { refs: [] }, Node { refs: [] }];
    group.nodes.clear();
}

fn root_component() {
    var st = State { list: List {
        head: Node { refs: [] }, links: [null, null], nodes: [Node { refs: [] }]
    }, other: 0 };
    st.list.first .= st.list.nodes[0];
    st.list.first .= null;
    st.list.nodes.clear();
    st.list.nodes.push(Node { refs: [] });
    link(st);
    assert(st.list.first .== st.list.nodes[0]);
    unlink(st);
    st.list.nodes.clear();
}

struct Entry { link: i64&<u32>?, flag: bool = false }
struct Saved { first: Entry&<u32>?, flag: bool = true, other: Entry = Entry {}, slots: Entry[..2] = [Entry {}, Entry {}], values: i64[>..] }

fn retained_limited_slot() {
    var x = Saved { slots: [Entry {}], values: [42] };
    x.slots[0].link .= x.values[0];
    x.first .= x.slots[0];
    x.slots = [];
    {
        let first .= x.first;
        if first { assert(first.link .== x.values[0]); } else { abort("missing first"); }
    }
    x.slots = [Entry {}, Entry {}];
    {
        let first .= x.first;
        if first { assert(first.link == null); }
    }
    x.values.clear();
}

struct PlainEntry { link: i64&? }
fn overwrite_plain_slots() {
    var values: i64[>..] = [42];
    var slots: PlainEntry[..2] = [PlainEntry {}, PlainEntry {}];
    slots[1].link .= values[0];
    let saved .= slots[1];
    slots = [PlainEntry {}, PlainEntry {}];
    values.clear();
    assert(saved.link == null);
}

fn release_plain_slot() {
    var values: i64[>..] = [42];
    var slots: PlainEntry[..] = [PlainEntry { link: values[0] }];
    {
        let saved .= slots[0];
        slots = [];
        assert(saved.link .== values[0]);
    }
    values.clear();
    assert(slots.len == 0);
}

fn unrelated_view() {
    var x = Saved { slots: [Entry {}], values: [42] };
    var independent = Entry {};
    let other .= independent;
    x.slots[0].link .= x.values[0];
    x.slots = [];
    x.values.clear();
    assert(other.link == null);
}

fn sibling_field_view() {
    var x = Saved { slots: [Entry {}], values: [42] };
    x.slots[0].link .= x.values[0];
    {
        let flag .= x.flag;
        x.slots = [];
        assert(flag);
    }
    x.values.clear();
}

fn replace_all_slots() {
    var x = Saved { slots: [Entry {}], values: [42] };
    x.first .= x.slots[0];
    x.slots[0].link .= x.values[0];
    x = Saved { slots: [Entry {}, Entry {}], values: [43] };
    assert(x.first == null && x.slots[0].link == null && x.values[0] == 43);
    x.first .= x.slots[1];
    x.slots[1].link .= x.values[0];
    x = Saved { null, true, Entry {}, [Entry {}; 2], [44] };
    assert(x.first == null && x.slots[1].link == null && x.values[0] == 44);
    x.first .= x.slots[1];
    x.slots[1].link .= x.values[0];
    x = Saved { values: [45] };
    assert(x.first == null && x.slots[1].link == null && x.values[0] == 45);
}

fn released_slot_view() {
    var x = Saved { values: [42] };
    x.slots[1].link .= x.values[0];
    {
        let saved .= x.slots[1];
        x.slots = [];
        assert(saved.link .== x.values[0]);
    }
    x.values.clear();
    x.values.push(43);
    x.slots = [Entry {}, Entry {}];
    x.slots[1].link .= x.values[0];
    let saved .= x.slots[1];
    x.slots = [];
    assert(saved.link .== x.values[0]);
    x.values.clear();
}

fn empty_limited_slots() {
    var x = Saved { values: [42] };
    x.slots[0].link .= x.values[0];
    x.slots.clear();
    x.values.clear();
    x.values.push(43);
    x.slots.push(Entry {});
    x.slots[0].link .= x.values[0];
    x.slots.resize(0);
    x.values.clear();
    x.values.push(44);
    x.slots.push(Entry {});
    x.slots[0].link .= x.values[0];
    x.slots.pop_n(x.slots.len);
    x.values.clear();
    x.values.push(45);
    x.slots.push(Entry {});
    x.slots[0].link .= x.values[0];
    let slots .= x.slots;
    const used = slots.len;
    { defer x.slots.pop_n(used); }
    x.values.clear();
    assert(x.slots.len == 0 && x.values.len == 0);
}

struct Siblings { slots: Entry[..3], other: Entry[..3], values: i64[>..] }

fn add_other(x: Siblings&) { x.other.push(Entry {}); }

fn empty_saved_slots() {
    var x = Siblings { slots: [Entry {}], other: [], values: [42] };
    const n = x.slots.len;
    x.other = [Entry {}];
    add_other(x);
    x.slots[0].link .= x.values[0];
    fn empty() { x.slots.pop_n(n); }
    empty();
    x.values.clear();
    assert(x.slots.len == 0 && x.other.len == 2 && x.values.len == 0);
}

fn pop_all_nodes() {
    var nodes: Node[>..] = [Node { refs: [] }, Node { refs: [] }];
    nodes[0].refs.push(nodes[1]);
    nodes.pop_n(nodes.len);
    assert(nodes.len == 0);
}

fn flat_slot_view() {
    var x = Saved { values: [42] };
    x.slots[0].link .= x.values[0];
    let flag .= x.slots[0].flag;
    x.slots = [];
    x.values.clear();
    assert(!flag);
}

fn replace_in_branches(choice: i64) {
    var x = Saved { values: [42] };
    x.slots[1].link .= x.values[0];
    x.first .= x.slots[1];
    x = if choice == 0 { Saved { values: [43] } } else { Saved { values: [44] } };
    assert(x.slots[1].link == null);
    x.first .= x.slots[1];
    x.slots[1].link .= x.values[0];
    x = match choice {
        0 => Saved { values: [45] },
        _ => Saved { values: [46] }
    };
    assert(x.slots[1].link == null);
}

fn clear_slots(slots: Entry[..2]&) { slots.clear(); }
fn save_other(x: Saved&) { x.first .= x.other; }
fn link_then_clear(x: Saved&) {
    x.slots[0].link .= x.values[0];
    x.slots.clear();
}

fn clear_through_helper() {
    var x = Saved { values: [42] };
    x.slots[1].link .= x.values[0];
    clear_slots(x.slots);
    x.values.clear();
    assert(x.values.len == 0);
    x.slots.push(Entry {});
    x.values.push(43);
    link_then_clear(x);
    x.values.clear();
}

fn disjoint_target() {
    var x = Saved { values: [42] };
    x.first .= x.other;
    x.slots[1].link .= x.values[0];
    x.slots.clear();
    x.values.clear();
    assert(x.first .== x.other);
    x.values.push(43);
    x.slots.push(Entry {});
    save_other(x);
    x.slots[0].link .= x.values[0];
    clear_slots(x.slots);
    x.values.clear();
    assert(x.first .== x.other);
}

struct Anchored { first: i64&<u32>?, head: i64, tail: i64[>..] }
fn trim_tail(x: Anchored&) {
    x.first .= x.head;
    x.tail.clear();
}
fn fixed_link_target() {
    var x = Anchored { head: 7, tail: [42] };
    x.first .= x.head;
    x.tail.clear();
    assert(x.first .== x.head);
    x.tail.push(42);
    trim_tail(x);
    assert(x.first .== x.head);
}

struct Cell { next: Cell&<u32>?, value: i64&<u32>? }
struct Chain { first: Cell[..2], second: Cell[..2], values: i64[>..] }
fn empty_cells(cells: Cell[..2]&) { cells.clear(); }
fn discarded_cycle() {
    var x = Chain { first: [Cell {}], second: [Cell {}], values: [42] };
    x.first[0].next .= x.second[0];
    x.second[0].next .= x.first[0];
    x.second[0].value .= x.values[0];
    {
        let view .= x.first[0];
        x.second.clear();
        empty_cells(x.first);
        let next .= view.next;
        if next { assert(next.value .== x.values[0]); }
    }
    x.values.clear();
    assert(x.values.len == 0);
}

fn main() {
    nested_arrays();
    indexed_field(1);
    root_component();
    retained_limited_slot();
    overwrite_plain_slots();
    release_plain_slot();
    unrelated_view();
    sibling_field_view();
    replace_all_slots();
    released_slot_view();
    empty_limited_slots();
    empty_saved_slots();
    pop_all_nodes();
    flat_slot_view();
    replace_in_branches(0);
    replace_in_branches(1);
    clear_through_helper();
    disjoint_target();
    fixed_link_target();
    discarded_cycle();
    print("ok");
}
