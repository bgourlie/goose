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

fn main() {
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
