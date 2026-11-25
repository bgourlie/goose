// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>?, refs: (Node&<u32>)[..2] }
struct List { head: Node, nodes: Node[>..] }

fn main() {
    var list = List { head: Node { refs: [] }, nodes: [Node { refs: [] }] };
    {
        let other .= list.nodes[0].refs.push(list.head);
        other.next .= list.nodes[0];
    }
    list.nodes.clear();
}
