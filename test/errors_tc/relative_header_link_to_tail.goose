// error: retained storage may have a self-relative link to a removed element
struct Node { flag: bool }
struct List { value: i64, saved: i64&<u32>?, first: Node&<u32>?, nodes: Node[>..] }

fn link(list: List&) {
    list.first .= list.nodes[0];
    list.saved .= list.value;
}

fn main() {
    var list = List { value: 42, nodes: [Node { flag: true }] };
    link(list);
    list.nodes.clear();
}
