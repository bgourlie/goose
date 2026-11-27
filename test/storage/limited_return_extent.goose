struct Node { next: Node&<u32>? }

fn initial(empty: bool) -> Node[..] {
    if empty { return [..3]; }
    [Node {}; 3]
}

fn named_initial(empty: bool) -> Node[..] {
    var nodes: Node[..] = initial(empty);
    return nodes;
}

fn three(early: bool) -> Node[..] {
    if early { return [Node {}, Node {}, Node {}]; }
    [Node {}; 3]
}

fn refill(early: bool) -> Node[..] { three(early) }
fn fresh() -> Node { Node {} }

fn linked(empty: bool, early: bool) -> Node[..] {
    var nodes: Node[..] = named_initial(empty);
    assert((nodes.len == 0) == empty && nodes.cap == 3);
    nodes.resize(nodes.cap, fresh());
    let saved .= nodes[2];
    nodes.pop_n(1);
    nodes = refill(early);
    nodes[0].next .= saved;
    return nodes;
}

fn main() {
    for empty in [false, true] {
        for early in [false, true] {
            let live: Node[] = linked(empty, early);
            assert(live.len == 3 && live[0].next .== live[2]);
        }
    }
    print("ok");
}
