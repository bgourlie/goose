struct Node { next: Node&<u32>? }
struct Cell { values: i64[2] = [4, 5], target: i64&<u32>? }

fn selected(form: i64, i: i64) -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    nodes.pop_n(1);
    let target: Node& = match form {
        0 => match i { 0 => nodes[0], _ => nodes[1] },
        1 => block { if i == 0 { break nodes[0]; } nodes[1] },
        _ => loop { if i == 0 { break nodes[0]; } break nodes[1]; },
    };
    nodes[1 - i].next .= target;
    return nodes;
}

fn slice_targets(use_first: bool) -> Node[..] {
    var nodes: Node[..] = [Node {}; 4];
    nodes.pop_n(1);
    nodes[0].next .= nodes[..][1];
    let tail = nodes[1..];
    nodes[1].next .= tail[..][1];
    var view = tail;
    view = if use_first { nodes[..1] } else { tail[..1] };
    for &selected in view { nodes[2].next .= selected; }
    return nodes;
}

fn field_element() -> Cell[..] {
    var cells: Cell[..] = [Cell {}; 3];
    cells.pop_n(1);
    cells[0].target .= cells[1].values[0];
    return cells;
}

fn optional_target(nodes: Node[..]&, present: bool) -> Node&? {
    if present { return nodes[1]; }
    return null;
}

fn nullable_binding(how: i64, present: bool) -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    nodes.pop_n(1);
    let target: Node&?;
    if how == 0 {
        target .= if present { nodes[1] } else { null };
    } else if how == 1 {
        if present { target .= nodes[1]; } else { target .= null; }
    } else if how == 2 {
        target .= if present { nodes[1] } else { default<Node&?>() };
    } else {
        target .= optional_target(nodes, present);
    }
    nodes[0].next .= target;
    return nodes;
}

fn make(target: Node&) -> Node { Node { next: target } }
fn forward(target: Node&) -> Node { make(target) }

fn stored_targets() -> Node[..] {
    var nodes: Node[..] = [Node {}; 4];
    nodes.pop_n(2);
    nodes[0] = forward(nodes[1]);
    let first: Node&;
    first .= nodes[0];
    nodes.append([Node { next: first }; 2]);
    return nodes;
}

fn identity(n: Node&) -> Node& { n }
fn choose(a: Node&, b: Node&, first: bool) -> Node& { if first { a } else { b } }
fn store(slot: Node&, target: Node&) { slot.next .= target; }
fn relay(slot: Node&, target: Node&) { store(slot, target); }

fn through_parameters(first: bool) -> Node[..] {
    var nodes: Node[..] = [Node {}; 4];
    nodes.pop_n(1);
    nodes[0].next .= identity(nodes[1]);
    relay(nodes[1], choose(nodes[0], nodes[2], first));
    return nodes;
}

fn mutable_target(rebind: bool) -> Node[..] {
    var nodes: Node[..] = [Node {}; 4];
    nodes.pop_n(1);
    var last .= nodes[1];
    if rebind { last .= nodes[2]; }
    nodes[0].next .= last;
    return nodes;
}

fn first_arg(n: Node&, ignored: i64) -> Node& { n }
fn evaluated_target() -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    let stale .= nodes[2];
    nodes.pop_n(1);
    var last .= nodes[1];
    nodes[0].next .= first_arg(last, block { last .= stale; 0 });
    return nodes;
}

fn main() {
    for first in [false, true] {
        let sliced: Node[] = slice_targets(first);
        assert(sliced[0].next .== sliced[1] && sliced[1].next .== sliced[2]);
        if first { assert(sliced[2].next .== sliced[0]); }
        else { assert(sliced[2].next .== sliced[1]); }
    }
    let evaluated: Node[] = evaluated_target();
    assert(evaluated[0].next .== evaluated[1]);
    for rebind in [false, true] {
        let nodes: Node[] = mutable_target(rebind);
        if rebind { assert(nodes[0].next .== nodes[2]); }
        else { assert(nodes[0].next .== nodes[1]); }
    }
    for first in [true, false] {
        let nodes: Node[] = through_parameters(first);
        assert(nodes[0].next .== nodes[1]);
        if first { assert(nodes[1].next .== nodes[0]); }
        else { assert(nodes[1].next .== nodes[2]); }
    }
    for how in 4 {
        for present in [false, true] {
            let nodes: Node[] = nullable_binding(how, present);
            if present { assert(nodes[0].next .== nodes[1]); }
            else { assert(nodes[0].next == null); }
        }
    }
    let filled: Node[] = stored_targets();
    assert(filled.len == 4 && filled[0].next .== filled[1]);
    assert(filled[2].next .== filled[0] && filled[3].next .== filled[0]);
    for form in 3 {
        for i in 2 {
            let nodes: Node[] = selected(form, i);
            assert(nodes.len == 2 && nodes[1 - i].next .== nodes[i]);
        }
    }
    let cells: Cell[] = field_element();
    assert(cells[0].target .== cells[1].values[0]);
    print("ok");
}
