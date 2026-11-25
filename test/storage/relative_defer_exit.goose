struct Node { next: Node&<u32>? }

fn reset(nodes: Node[>..]&, early: bool) {
    defer { nodes.clear(); }
    defer { nodes[0].next .= nodes[1]; }
    if early { return; }
}

fn stopped_unwind(nodes: Node[>..]&) {
    defer { nodes.pop_n(1); }
    defer { abort("stop"); }
}

fn stopped(stop: bool) {
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    if stop { stopped_unwind(nodes); }
    if stop {
        defer { nodes.pop_n(1); }
        { defer { abort("stop"); } }
    }
    if stop {
        defer { nodes.pop_n(1); }
        defer { abort("stop"); }
        return;
    }
}

fn explicit_result(stop: bool) -> Node[] {
    var nodes: Node[] = [Node {}, Node {}];
    if stop {
        nodes[0].next .= nodes[1];
        defer { abort("stop"); }
        return nodes;
    }
    return nodes;
}

fn tail_result(stop: bool) -> Node[] {
    var nodes: Node[] = [Node {}, Node {}];
    if !stop { return nodes; }
    nodes[0].next .= nodes[1];
    defer { abort("stop"); }
    nodes
}

fn invoke<F>() { F(); }
fn linked() -> Node[] {
    var nodes: Node[] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    return nodes;
}
fn distant_result(stop: bool) -> Node[] {
    var nodes: Node[] = [Node {}, Node {}];
    if stop {
        defer { abort("stop"); }
        invoke() { return linked() from distant_result; };
    }
    return nodes;
}

fn main() {
    var explicit: Node[>..<] = explicit_result(false);
    var tail: Node[>..<] = tail_result(false);
    var distant: Node[>..<] = distant_result(false);
    assert(explicit.len == 2 && tail.len == 2 && distant.len == 2);
    stopped(false);
    var nodes: Node[>..] = [Node {}, Node {}];
    { defer { nodes[0].next .= nodes[1]; } }
    nodes.clear();
    nodes.push(Node {});
    nodes.pop_n(1);
    for i in 2 {
        nodes.push(Node {});
        nodes.push(Node {});
        defer { nodes.clear(); }
        defer { nodes[0].next .= nodes[1]; }
        if i == 0 { continue; }
        break;
    }
    for i in 2 {
        nodes.push(Node {});
        nodes.push(Node {});
        reset(nodes, i == 0);
        nodes.push(Node {});
        nodes.pop_n(1);
    }
    assert(nodes.len == 0);
    print("ok");
}
