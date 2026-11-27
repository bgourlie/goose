struct Node { next: Node&<u32>? }

fn trim(nodes: Node[..]&) { nodes.pop_n(1); }
fn link(nodes: Node[..]&) { nodes[0].next .= nodes[1]; }
fn relay(nodes: Node[..]&) { link(nodes); }

fn target(nodes: Node[..]&, direct: bool) -> Node& {
    if direct { return nodes[1]; }
    let target .= nodes[1];
    return target;
}

fn by_reference(how: i64) -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    trim(nodes);
    if how == 0 {
        let last .= nodes.push(Node {});
        nodes[0].next .= last;
    } else if how == 1 {
        for &n, i in nodes { if i > 0 { nodes[0].next .= n; } }
    } else {
        nodes[0].next .= target(nodes, how == 2);
    }
    return nodes;
}

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
    for how in 4 {
        let linked: Node[] = by_reference(how);
        assert(linked[0].next .== linked[linked.len - 1]);
    }
    for direct in [true, false] {
        let live: Node[] = pair(direct);
        assert(live.len == 2 && live[0].next .== live[1]);
        let linked: Node[] = from_helper(direct);
        assert(linked.len == 2 && linked[0].next .== linked[1]);
    }
    print("ok");
}
