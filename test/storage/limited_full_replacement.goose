struct Node { next: Node&<u32>? }
const TWO = 2;
const CAP = TWO;

fn pair(shrink: bool) -> Node[..] {
    var nodes: Node[..] = [Node {}, Node {}];
    if shrink { nodes.pop_n(1); }
    nodes = if shrink { [Node {}; 2] } else { [Node {}, Node {}] };
    nodes[0].next .= nodes[1];
    return nodes;
}

fn reserved() -> Node[..] {
    var nodes: Node[..] = [..CAP];
    nodes.push(Node {});
    nodes.push(Node {});
    let last .= nodes[1];
    nodes.clear();
    var alias .= nodes;
    alias = [Node {}; CAP];
    nodes[0].next .= last;
    return nodes;
}

fn full_again() -> Node[..] {
    var nodes: Node[..] = [Node {}; 2];
    let last .= nodes[1];
    nodes.pop_n(1);
    nodes.push(Node {});
    let alias .= nodes;
    nodes.resize(alias.cap);
    nodes[0].next .= last;
    return nodes;
}

fn constant_capacity() -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    let last .= nodes[2];
    nodes.pop_n(1);
    nodes.push(Node {});
    nodes.resize(3);
    nodes[0].next .= last;
    return nodes;
}

fn fill(calls: i64&) -> Node { calls = calls + 1; return Node {}; }
fn filled_to_capacity(calls: i64&) -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    let last .= nodes[2];
    nodes.pop_n(1);
    nodes.resize(nodes.cap, fill(calls));
    nodes[0].next .= last;
    return nodes;
}

fn fresh() -> Node { Node {} }
fn restore(nodes: Node[..]&) { nodes.resize(nodes.cap, fresh()); }
fn forward(nodes: Node[..]&, early: bool) {
    if early {
        nodes.pop_n(1);
        restore(nodes);
        return;
    }
    defer { restore(nodes); }
}

fn restored_by_helper(direct: bool, early: bool) -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    let last .= nodes[2];
    nodes.pop_n(1);
    if direct { restore(nodes); } else { forward(nodes, early); }
    nodes[0].next .= last;
    return nodes;
}

fn main() {
    for direct in [true, false] {
        for early in [true, false] {
            let live: Node[] = restored_by_helper(direct, early);
            assert(live.len == 3 && live[0].next .== live[2]);
        }
    }
    var calls = 0;
    let filled: Node[] = filled_to_capacity(calls);
    assert(calls == 1 && filled.len == 3 && filled[0].next .== filled[2]);
    let restored: Node[] = constant_capacity();
    assert(restored.len == 3 && restored[0].next .== restored[2]);
    let full: Node[] = full_again();
    assert(full.len == 2 && full[0].next .== full[1]);
    for shrink in [true, false] {
        let live: Node[] = pair(shrink);
        assert(live.len == 2 && live[0].next .== live[1]);
    }
    let live: Node[] = reserved();
    assert(live.len == 2 && live[0].next .== live[1]);
    print("ok");
}
