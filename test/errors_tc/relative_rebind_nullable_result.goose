// error: cannot clear list: retained storage may have a self-relative link
struct Node { value: i64 }
struct List { first: Node&<u32>?, nodes: Node[>..] }
fn choose(list: List&, keep: bool) -> Node&? {
    if keep { return list.nodes[0]; }
    return default<Node&?>();
}
fn build(keep: bool) {
    var list = List { nodes: [Node { value: 1 }] };
    list.first .= choose(list, keep);
    list.nodes.clear();
}
fn main() { build(true); }
