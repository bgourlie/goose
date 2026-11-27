struct Node { next: Node&<u32>? }
struct Slot { next: Slot&<u32>?, plain: i64&? }
let ZERO = 0;
let length = 0;
let limited_count = 0;
let empty_count = 0;
let slot_count = 0;

fn clear(nodes: Node[>..]&) { nodes.clear(); }
fn resize(nodes: Node[>..]&) { nodes.resize(length); }
fn reset(nodes: Node[>..]&) { nodes.resize(ZERO); }
fn reset_or_keep(nodes: Node[>..]&, empty: bool) {
    if empty { reset(nodes); } else { nodes.pop_n(ZERO); }
}

fn change(n: i64&) { n = 1; }

fn resize_limited(nodes: Node[..]&) { nodes.resize(limited_count); }
fn resize_unlinked() {
    var nodes: Node[..] = [Node {}, Node {}];
    resize_limited(nodes);
    assert(nodes.len == 0);
    change(limited_count);
    nodes.push(Node {});
    nodes.push(Node {});
    resize_limited(nodes);
    assert(nodes.len == 1);
}

fn empty_limited(nodes: Node[..]&) { nodes.resize(empty_count); }
fn empty_pair() -> Node[..] {
    var nodes: Node[..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    let saved .= nodes[0];
    empty_limited(nodes);
    assert(saved.next != null);
    return nodes;
}

fn release_plain_view() {
    var values: i64[>..] = [42];
    var slots: Slot[..] = [Slot {}, Slot {}];
    slots[0].next .= slots[1];
    slots[0].plain .= values[0];
    slots.resize(slot_count);
    values.clear();
    assert(slots.len == 0);
}

fn resize_after_clear() {
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    nodes.clear();
    nodes.push(Node {});
    resize(nodes);
    assert(nodes.len == 0);
    change(length);
    nodes.push(Node {});
    nodes.push(Node {});
    resize(nodes);
    assert(nodes.len == 1);
}

fn clear_alias(nodes: Node[>..]&, direct: bool) {
    let alias .= nodes;
    let another .= alias;
    if direct { nodes.clear(); } else { another.clear(); }
}

fn main() {
    resize_unlinked();
    release_plain_view();
    let empty: Node[] = empty_pair();
    assert(empty.len == 0);
    resize_after_clear();
    var resized: Node[>..] = [Node {}, Node {}];
    resized[0].next .= resized[1];
    resized.resize(1 - 1);
    resized.push(Node {});
    resized.push(Node {});
    resized[0].next .= resized[1];
    reset_or_keep(resized, false);
    assert(resized.len == 2 && resized[0].next .== resized[1]);
    reset(resized);
    assert(resized.len == 0);
    resized.push(Node {});
    resized.pop_n(1);
    var nodes: Node[>..] = [Node {}, Node {}];
    var other: Node[>..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    other[0].next .= other[1];
    var alias .= nodes;
    alias.clear();
    alias .= other;
    nodes.push(Node {});
    nodes.pop_n(1);
    assert(nodes.len == 0 && alias[0].next .== other[1]);

    var other_alias .= other;
    clear(other_alias);
    other.push(Node {});
    other.pop_n(1);
    assert(other.len == 0);
    nodes.push(Node {});
    nodes.push(Node {});
    nodes[0].next .= nodes[1];
    loop {
        let alias .= nodes;
        alias.clear();
        break;
    }
    nodes.push(Node {});
    nodes.pop_n(1);
    assert(nodes.len == 0);
    for direct in [false, true] {
        nodes.push(Node {});
        nodes.push(Node {});
        nodes[0].next .= nodes[1];
        clear_alias(nodes, direct);
        nodes.push(Node {});
        nodes.pop_n(1);
        assert(nodes.len == 0);
    }
    print("ok");
}
