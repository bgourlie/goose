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

fn main() {
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
