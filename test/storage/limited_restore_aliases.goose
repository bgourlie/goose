struct Node { next: Node&<u32>? }
struct Bag { items: Node[..] }

fn fresh() -> Node { Node {} }
fn prepare(target: Node[..]&, other: Node[..]&, trim_first: bool) {
    if trim_first {
        other.pop_n(1);
        target.resize(target.cap, fresh());
        return;
    }
    defer { other.pop_n(1); }
    target.resize(target.cap, fresh());
}

fn restored(trim_first: bool, field: bool) -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    var other: Node[..] = [Node {}; 3];
    var bag = Bag { items: [Node {}; 3] };
    let saved .= nodes[2];
    nodes.pop_n(1);
    fn forward(a: Node[..]&, b: Node[..]&) { prepare(a, b, trim_first); }
    fn from_bag(t: Node[..]&, obj: Bag&) { forward(t, obj.items); }
    fn from_either(t: Node[..]&, a: Node[..]&, b: Node[..]&, choose_b: bool) {
        var writer .= a;
        if choose_b { writer .= b; }
        forward(t, writer);
    }
    if field { from_bag(nodes, bag); } else { from_either(nodes, other, bag.items, trim_first); }
    nodes[0].next .= saved;
    return nodes;
}

fn captured() -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    var other: Node[..] = [Node {}; 3];
    let saved .= nodes[2];
    nodes.pop_n(1);
    fn restore(trim: Node[..]&) {
        defer { trim.pop_n(1); }
        nodes.resize(nodes.cap, fresh());
    }
    restore(other);
    assert(other.len == 2);
    nodes[0].next .= saved;
    return nodes;
}

fn restored_last() -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    let saved .= nodes[2];
    fn restore(target: Node[..]&, other: Node[..]&) {
        defer { target.resize(target.cap, fresh()); }
        other.pop_n(1);
    }
    restore(nodes, nodes);
    nodes[0].next .= saved;
    return nodes;
}

fn main() {
    for trim_first in [true, false] {
        for field in [true, false] {
            let live: Node[] = restored(trim_first, field);
            assert(live.len == 3 && live[0].next .== live[2]);
        }
    }
    let live: Node[] = captured();
    assert(live.len == 3 && live[0].next .== live[2]);
    let alias: Node[] = restored_last();
    assert(alias.len == 3 && alias[0].next .== alias[2]);
    print("ok");
}
