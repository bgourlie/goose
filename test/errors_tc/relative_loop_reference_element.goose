// error: retained storage may have a self-relative link to a removed element
struct Node { refs: Node&<u32>?[1] }
struct List { head: Node, nodes: Node[>..] }

fn main() {
    var list = List { head: Node { refs: [null] }, nodes: [Node { refs: [null] }] };
    list.nodes[0].refs[0] .= list.head;
    for &item in list.nodes[0].refs {
        if item { item.refs[0] .= list.nodes[0]; }
    }
    list.nodes.clear();
}
