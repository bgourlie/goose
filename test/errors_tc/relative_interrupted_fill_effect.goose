// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>?, n: i64 }
struct List { head: Node, header: Node[1], nodes: Node[>..] }

fn leave(list: List&) -> i64 {
    list.head.next .= list.nodes[0];
    return from install;
}
fn install(list: List&) {
    list.header = [Node { next: list.nodes[0], n: leave(list) }; 1];
}
fn main() {
    var list = List { head: Node { n: 1 }, header: [Node { n: 2 }], nodes: [Node { n: 3 }] };
    install(list);
    list.nodes.clear();
}
