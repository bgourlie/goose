struct Node { next: Node&<u32>? }
struct Reset {}
var nodes: Node[>..] = [];

fn reset() -> i64 {
    nodes.clear();
    nodes.push(Node {});
    nodes.push(Node {});
    return 0;
}
fn trim() -> i64 { nodes.pop_n(1); return nodes.len; }
fn step() -> i64 {
    let remaining = trim();
    nodes.push(Node {});
    nodes[0].next .= nodes[1];
    return remaining;
}

fn format(out: u8[>..]&, r: Reset) { reset(); }
// This overload has the builtin call's arity, but its last type differs.
fn format(out: u8[>..]&, r: Reset, other: Reset) { out.append("two"); }
enum Action { One, Two }
fn format(out: u8[>..]&, action: Action.One, count: i64) { out.append("one"); }
fn format(out: u8[>..]&, action: Action.Two, count: i64) { out.append("two"); }
struct Box<T> { first: i64 = reset(), value: T }

fn probed_break(flag: bool) {
    reset();
    nodes[0].next .= nodes[1];
    block {
        let box = Box { value: if flag { break; } else { 17 } };
        assert(box.value == 17);
    }
    assert(trim() == 1);

    reset();
    nodes[0].next .= nodes[1];
    let n = block {
        let box = Box { value: if flag { break 9; } else { loop { break 17; } } };
        box.value
    };
    assert(n == (if flag { 9 } else { 17 }) && trim() == 1);
}

fn probed_continue() {
    reset();
    for i in 2 {
        nodes.pop_n(1);
        nodes.push(Node {});
        nodes[0].next .= nodes[1];
        let box = Box { value: if i == 0 { continue; } else { 17 } };
        assert(box.value == 17);
    }
}

fn main() {
    probed_break(true);
    probed_break(false);
    probed_continue();
    reset();
    step().print();
    reset();
    print(step());
    reset();
    assert(step().str() == "1");

    var out: u8[>..] = [];
    format(out, Reset {}, trim());
    assert(out == "1" && nodes.len == 1);
    reset();
    nodes[0].next .= nodes[1];
    out.format(Reset {}, trim());
    assert(out == "11" && nodes.len == 1);

    reset();
    let action: Action = Action.One;
    format(out, action, trim());
    assert(out == "11one" && nodes.len == 1);

    reset();
    nodes[0].next .= nodes[1];
    let inferred = Box { value: trim() };
    assert(inferred.value == 1 && nodes.len == 1);
    reset();
    nodes[0].next .= nodes[1];
    let explicit = Box<i64> { value: trim() };
    assert(explicit.value == 1 && nodes.len == 1);
}
