// error: cannot clear list: retained storage may have a self-relative link
struct Node { value: i64 }
struct List { first: Node&<u32>?, nodes: Node[>..] }
fn build(early: bool) {
    var list = List { nodes: [Node { value: 1 }] };
    fn reset() {
        list.first .= block {
            list.first .= list.nodes[0];
            if early { return; }
            null
        };
    }
    reset();
    list.nodes.clear();
}
fn main() { build(true); }
