// error: retained storage may have a self-relative link to a removed element
struct Node { value: i64 }
struct List { first: Node&<u32>?, second: Node&<u32>?, nodes: Node[>..] }
var list = List { nodes: [] };

export fn clear_first() { list.first .= null; list.nodes.clear(); }
export fn link_second() {
    list.nodes.push(Node { value: 1 });
    list.second .= list.nodes[0];
}
fn main() {}
