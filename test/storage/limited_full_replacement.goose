struct Node { next: Node&<u32>? }

fn pair(shrink: bool) -> Node[..] {
    var nodes: Node[..] = [Node {}, Node {}];
    if shrink { nodes.pop_n(1); }
    nodes = if shrink { [Node {}; 2] } else { [Node {}, Node {}] };
    nodes[0].next .= nodes[1];
    return nodes;
}

fn reserved() -> Node[..] {
    var nodes: Node[..] = [..2];
    var alias .= nodes;
    alias = [Node {}; 2];
    nodes[0].next .= nodes[1];
    return nodes;
}

fn main() {
    for shrink in [true, false] {
        let live: Node[] = pair(shrink);
        assert(live.len == 2 && live[0].next .== live[1]);
    }
    let live: Node[] = reserved();
    assert(live.len == 2 && live[0].next .== live[1]);
    print("ok");
}
