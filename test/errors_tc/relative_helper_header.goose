// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
struct List { head: Node, nodes: Node[>..] }

fn link(first: Node&, second: Node&, src: Node&) {
    first.next .= src;
    second.next .= src;
}

fn main() {
    var list = List { head: Node {}, nodes: [Node {}, Node {}] };
    link(list.nodes[0], list.head, list.nodes[1]);
    list.nodes.clear();
}
