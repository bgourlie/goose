// error: retained storage may have a self-relative link to a removed element
struct Node { value: i64 }
struct List { links: (Node&<u32>?)[2], nodes: Node[>..] }

fn main() {
    var xs = List { links: [null, null], nodes: [Node { value: 1 }] };
    xs.links[1] .= xs.nodes[0];
    xs.links[0] .= null;
    xs.nodes.clear();
}
