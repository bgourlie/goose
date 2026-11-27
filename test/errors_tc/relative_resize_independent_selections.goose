// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn select_nodes(a: Node[>..]&, b: Node[>..]&, first: bool) -> Node[>..]& {
    let selected: Node[>..]& = if first { a } else { b };
    selected
}

fn trim(first: bool, second: bool) {
    var a: Node[>..] = [Node {}, Node {}];
    var b: Node[>..] = [Node {}];
    a[0].next .= a[1];
    let target .= select_nodes(a, b, first);
    let source .= select_nodes(a, b, second);
    target.resize(source.len);
}

fn main() { trim(true, false); }
