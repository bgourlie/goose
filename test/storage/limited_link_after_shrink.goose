struct Node { next: Node&<u32>? }

fn trim(nodes: Node[..]&) { nodes.pop_n(1); }
fn link(nodes: Node[..]&) { nodes[0].next .= nodes[1]; }
fn relay(nodes: Node[..]&) { link(nodes); }

fn trim_then_link(view: Node[..]&, nodes: Node[..]&) {
    trim(view);
    let target .= nodes[1];
    nodes[0].next .= target;
}

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

fn from_helper(direct: bool) -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    if direct {
        trim(nodes);
        relay(nodes);
    } else {
        trim_then_link(nodes, nodes);
    }
    return nodes;
}

fn main() {
    for direct in [true, false] {
        let live: Node[] = pair(direct);
        assert(live.len == 2 && live[0].next .== live[1]);
        let linked: Node[] = from_helper(direct);
        assert(linked.len == 2 && linked[0].next .== linked[1]);
    }
    print("ok");
}
