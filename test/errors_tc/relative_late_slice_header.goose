// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
struct List { header: Node[1], nodes: Node[>..] }
fn link(list: List&, in_tail: bool) {
    let view: Node[:];
    if in_tail { view = list.nodes[..]; } else { view = list.header[..]; }
    view[0].next .= list.nodes[0];
}
fn main() {
    var list = List { header: [Node {}], nodes: [Node {}] };
    link(list, false);
    list.nodes.clear();
}
