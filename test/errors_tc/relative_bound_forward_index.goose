// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
fn main() {
    var nodes: Node[>..] = [Node {}; 2];
    {
        let later .= nodes[1];
        nodes[0].next .= later;
    }
    nodes.pop();
}
