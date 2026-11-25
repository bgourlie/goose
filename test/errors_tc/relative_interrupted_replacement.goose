// error: this exit can leave list partially rebuilt
struct Node { n: i64 }
struct List { n: i64, head: Node&<u32>?, nodes: Node[>..] }

fn leave() -> i64 { return from install; }
fn install(list: List&) { list = List { n: leave(), nodes: [] }; }

fn main() {
    var list = List { n: 1, nodes: [Node { n: 42 }] };
    list.head .= list.nodes[0];
    install(list);
}
