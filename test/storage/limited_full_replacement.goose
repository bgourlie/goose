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
    nodes.resize(nodes.cap);
    nodes[0].next .= last;
    return nodes;
}

fn main() {
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
