// error: retained storage may have a self-relative link to a removed element
struct Node { value: i64 }
struct Header { link: Node&<u32>? }
struct List { left: Header, right: Header, nodes: Node[>..] }

fn link(header: Header&, node: Node&) { header.link .= node; }
fn edit(list: List&, left: bool) {
    link(if left { list.left } else { list.right }, list.nodes[0]);
    list.left.link .= null;
}

fn main() {
    var list = List { left: Header {}, right: Header {}, nodes: [Node { value: 1 }] };
    edit(list, false);
    list.nodes.clear();
}
