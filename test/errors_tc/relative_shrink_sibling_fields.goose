// error: retained storage may have a self-relative link to a removed element
struct Node { n: i64 }
struct Header { link: Node&<u32>? }
struct List { left: Header, right: Header, nodes: Node[>..] }

fn edit(left: Header&, right: Header&, source: Node&) {
    left.link .= source;
    right.link .= null;
}

fn trim(keep: i64) {
    var xs = List { left: Header {}, right: Header {}, nodes: [Node { n: 0 }, Node { n: 1 }] };
    edit(xs.left, xs.right, xs.nodes[1]);
    xs.nodes.resize(keep);
}

fn main() { trim(2); }
