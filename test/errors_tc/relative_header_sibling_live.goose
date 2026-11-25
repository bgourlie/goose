// error: retained storage may have a self-relative link to a removed element
struct Node { value: i64 }
struct Header { first: Node&<u32>?, second: Node&<u32>? }
struct List { header: Header, nodes: Node[>..] }

fn link(header: Header&, node: Node&) {
    header.first .= node;
    header.second .= node;
}

fn main() {
    var list = List { header: Header {}, nodes: [Node { value: 1 }] };
    link(list.header, list.nodes[0]);
    list.header.first .= null;
    list.nodes.clear();
}
