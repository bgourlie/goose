struct Node { next: Node&<u32>? }
struct Header { slots: Node[..2], spare: Node }
struct List { header: Header, tail: Node[>..] }

fn linked() -> Node[] {
    var xs: Node[] = [Node {}, Node {}];
    xs[0].next .= xs[1];
    return xs;
}
fn header() -> Header {
    Header { slots: linked(), spare: Node {} }
}
fn main() {
    var list = List {
        header: Header { slots: linked(), spare: Node {} },
        tail: [Node {}]
    };
    assert(list.header.slots[0].next .== list.header.slots[1]);
    list.header.slots = [];
    list.tail.clear();

    list.tail.push(Node {});
    list.header = header();
    assert(list.header.slots[0].next .== list.header.slots[1]);
    list.header.slots = [Node {}, Node {}];
    list.tail.clear();
    print("ok");
}
