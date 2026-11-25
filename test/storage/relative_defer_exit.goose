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

fn break_result(stop: bool) -> Node[] {
    block {
        if stop {
            defer { abort("stop"); }
            break linked();
        }
        [Node {}]
    }
}

fn block_tail(stop: bool) -> Node[] {
    block {
        if !stop { break [Node {}]; }
        defer { abort("stop"); }
        linked()
    }
}

fn match_result(index: i64) -> Node[] {
    match index {
        0 => { defer { abort("stop"); } linked() },
        1 => { defer { abort("stop"); } linked() },
        _ => [Node {}],
    }
}

fn stop_before_break() { abort("stop"); }
fn break_operand(stop: bool) -> i64 {
    let value = if stop { loop { break stop_before_break(); } } else { 42 };
    return value;
}

fn stopped_rebind(stop: bool) {
    var nodes: Node[>..] = [Node {}, Node {}];
    if stop {
        nodes[0].next .= block { defer { abort("stop"); } nodes[1] };
    }
    nodes.pop_n(1);
}

struct Stop { flag: bool }
fn format(out: u8[>..]&, stop: Stop) { abort("stop"); }
fn formatted_result(stop: bool) -> Node[] {
    if stop {
        defer { print([Stop { flag: true }; 2]); }
        return linked();
    }
    [Node {}]
}

fn main() {
    var explicit: Node[>..<] = explicit_result(false);
    var tail: Node[>..<] = tail_result(false);
    var distant: Node[>..<] = distant_result(false);
    assert(explicit.len == 2 && tail.len == 2 && distant.len == 2);
    var from_break: Node[>..<] = break_result(false);
    var from_tail: Node[>..<] = block_tail(false);
    var from_format: Node[>..<] = formatted_result(false);
    var from_match: Node[>..<] = match_result(2);
    assert(from_break.len == 1 && from_tail.len == 1 && from_format.len == 1 && from_match.len == 1);
    assert(break_operand(false) == 42);
    stopped_rebind(false);
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
