struct Node { next: Node&<u32>? }
struct List { header: Node[..2], nodes: Node[>..] }

fn first(list: List&, count: i64&) -> Node& {
    count += 1;
    return list.nodes[0];
}

fn empty(first: Node&) -> Node[..2] { [Node { next: first }; 1 - 1] }
fn maybe_link(first: Node&, stop: bool) -> Node {
    if stop {
        defer { abort("stop"); }
        return Node { next: first };
    }
    Node {}
}
fn conditional_tail(first: Node&, stop: bool) -> Node {
    if stop {
        defer { abort("stop"); }
        Node { next: first }
    } else { Node {} }
}

fn main() {
    var list = List { header: [], nodes: [Node {}] };
    var count = 0;
    list.header = [Node { next: first(list, count) }; 0];
    assert(count == 1 && list.header.len == 0);
    list.nodes.clear();
    list.nodes.push(Node {});
    list.header = empty(list.nodes[0]);
    list.nodes.clear();
    list.nodes.push(Node {});
    list.header = [maybe_link(list.nodes[0], false), conditional_tail(list.nodes[0], false)];
    list.nodes.clear();
    print("ok");
}
