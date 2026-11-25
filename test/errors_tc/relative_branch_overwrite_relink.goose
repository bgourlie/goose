// error: retained storage may have a self-relative link to a removed element
struct Node { value: i64 }
struct Header { link: Node&<u32>? }
struct List { header: Header, nodes: Node[>..] }

fn update(list: List&, replace: bool) {
    if replace { list.header = Header { link: list.nodes[0] }; }
    else { list.header.link .= null; }
}

fn main() {
    var list = List { header: Header {}, nodes: [Node { value: 1 }] };
    update(list, true);
    list.nodes.clear();
}
