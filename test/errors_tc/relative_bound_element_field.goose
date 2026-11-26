// error: retained storage may have a self-relative link to a removed element
struct Node { left: Node&<u32>?, right: Node&<u32>? }

fn main() {
    var nodes: Node[>..] = [Node {}, Node {}];
    {
        let first .= nodes[0];
        first.left .= nodes[1];
        first.right .= null;
    }
    nodes.pop_n(1);
}
