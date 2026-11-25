// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
struct List { head: Node, nodes: Node[>..] }

fn link(list: List&, header: bool) {
    let dst: Node&;
    if header { dst .= list.head; } else { dst .= list.nodes[0]; }
    dst.next .= list.nodes[1];
}

fn main() {
    var list = List { head: Node {}, nodes: [Node {}, Node {}] };
    link(list, true);
    list.nodes.clear();
}
