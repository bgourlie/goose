// error: retained storage may have a self-relative link to a removed element
struct Node { value: i64 }
struct Header { link: Node&<u32>?, other: Node&<u32>? }
struct List { header: Header, nodes: Node[>..] }

fn reset(list: List&, whole: bool) {
    if whole { list.header = Header {}; return; }
    list.header.link .= null;
}

fn main() {
    var list = List { header: Header {}, nodes: [Node { value: 1 }] };
    list.header.other .= list.nodes[0];
    reset(list, false);
    list.nodes.clear();
}
