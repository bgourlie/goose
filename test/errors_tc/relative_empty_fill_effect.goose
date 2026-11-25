// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
struct List { head: Node, header: Node[..2], nodes: Node[>..] }

fn link(list: List&) -> Node& {
    list.head.next .= list.nodes[0];
    return list.nodes[0];
}
fn main() {
    var list = List { head: Node {}, header: [], nodes: [Node {}] };
    list.header = [Node { next: link(list) }; 0];
    list.nodes.clear();
}
