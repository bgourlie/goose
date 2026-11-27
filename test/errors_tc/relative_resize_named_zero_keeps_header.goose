// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
struct List { head: Node&<u32>?, nodes: Node[>..] }
let count = 0;

fn resize(list: List&) { list.nodes.resize(count); }
fn main() {
    var list = List { nodes: [Node {}, Node {}] };
    list.head .= list.nodes[1];
    resize(list);
}
