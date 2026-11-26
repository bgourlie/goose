struct Node { next: Node&<u32>? }

fn trim(nodes: Node[..]&) { nodes.pop_n(1); }

fn pair(direct: bool) -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    var alias .= nodes;
    trim(alias);
    if direct {
        nodes[0].next .= nodes[1];
    } else {
        let last .= alias[1];
        for i in nodes.len - 1 { nodes[i].next .= last; }
    }
    return nodes;
}

fn main() {
    for direct in [true, false] {
        let live: Node[] = pair(direct);
        assert(live.len == 2 && live[0].next .== live[1]);
    }
    print("ok");
}
