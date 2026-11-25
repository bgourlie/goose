// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
struct List { head: Node, nodes: Node[>..] }

fn link(list: List&, header: bool) {
    let target: Node&? = if header { list.head } else { list.nodes[0] };
    if target { target.next .= list.nodes[1]; }
}

fn main() {
    var list = List { head: Node {}, nodes: [Node {}, Node {}] };
    link(list, true);
    list.nodes.clear();
}
