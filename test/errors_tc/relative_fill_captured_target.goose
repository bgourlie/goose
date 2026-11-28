// xfail: accepts-invalid
// error: a link target captured by the array fill
// The first field captures the target; constructing the second field clears its storage (§§4.2, 5.1).
struct Node { next: Node&<u32>? }
struct Group { header: Node[1], n: i64 }
struct List { groups: Group[1], nodes: Node[>..] }

fn shrink(list: List&) -> i64 { list.nodes.clear(); 1 }
fn install(list: List&) {
    list.groups = [Group { header: [Node { next: list.nodes[0] }; 1], n: shrink(list) }; 1];
}
fn main() {
    var list = List { groups: [Group { header: [Node {}], n: 0 }], nodes: [Node {}] };
    install(list);
}
