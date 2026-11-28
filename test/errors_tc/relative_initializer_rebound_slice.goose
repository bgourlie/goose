// error: retained storage may have a self-relative link to a removed element
struct Node { tag: i64 = 0, next: Node&<u32>? }
fn main() {
    var nodes: Node[>..] = [Node {}; 2];
    {
        var view = nodes[0..1];
        fn advance() -> i64 { view = nodes[1..2]; return 0; }
        view[0] = Node { tag: advance(), next: view[0] };
    }
    nodes.pop();
}
