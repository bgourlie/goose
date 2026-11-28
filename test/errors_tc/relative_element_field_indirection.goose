// error: retained storage may have a self-relative link to a removed element
struct Node { value: i64 = 0, peer: Node&<u32>, selected: i64&<u32>? }

fn main() {
    var nodes: Node[>..] = [Node { peer: self }, Node { peer: self }];
    {
        let n .= nodes[0];
        n.peer .= nodes[1];
        n.selected .= n.peer.value;
        n.peer .= n;
    }
    nodes.pop();
}
