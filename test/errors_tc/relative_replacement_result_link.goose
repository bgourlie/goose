// error: retained storage may have a self-relative link to a removed element
struct Node { n: i64 }
struct Header { link: Node&<u32>? }
struct List { header: Header, tail: Node[>..] }
fn plant(list: List&) -> Node& {
    list.header.link .= list.tail[0];
    return list.tail[1];
}
fn header(node: Node&) -> Header { Header { link: node } }
fn main() {
    var list = List { header: Header {}, tail: [Node { n: 1 }, Node { n: 2 }] };
    list.header = header(plant(list));
    list.tail.pop_n(1);
}
