// error: retained storage may have a self-relative link to a removed element
struct Node { value: i64 }
struct Header { link: Node&<u32>? }
struct List { first: Header, second: Header, nodes: Node[>..] }
fn main() {
    var list = List { first: Header {}, second: Header {}, nodes: [Node { value: 42 }] };
    list.second.link .= list.nodes[0];
    fn header() -> Header& { list.first }
    header().link .= null;
    list.nodes.clear();
}
