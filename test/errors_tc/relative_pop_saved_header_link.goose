// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
struct List { head: Node&<u32>?, nodes: Node[>..] }

fn main() {
    var list = List { nodes: [Node {}, Node {}] };
    list.head .= list.nodes[1];
    const count = list.nodes.len;
    list.nodes.pop_n(count);
}
