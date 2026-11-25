// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
struct List { head: Node, nodes: Node[>..] }

fn link(list: List&, indirect: bool) {
    let target: Node&?;
    if indirect { target .= list.nodes[0].next; } else { target .= list.nodes[0]; }
    if target { target.next .= list.nodes[1]; }
}

fn main() {
    var list = List { head: Node {}, nodes: [Node {}, Node {}] };
    list.nodes[0].next .= list.head;
    link(list, true);
    list.nodes.clear();
}
