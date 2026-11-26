// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
struct List { header: Node[2], nodes: Node[>..] }

fn main() {
    var list = List { header: [Node {}, Node {}], nodes: [Node {}, Node {}] };
    {
        var view = list.nodes[..];
        for &node in view {
            node.next .= list.nodes[1];
            view = list.header[..];
        }
    }
    list.nodes.clear();
}
