// error: retained storage may have a self-relative link to a removed element
struct Node { value: i64 = 0, next: Node&<u32>? }

fn main() {
    var nodes: Node[>..] = [Node {}, Node {}];
    {
        let first .= nodes[0];
        let last .= nodes[1];
        first.next .= last;
    }
    nodes.pop_n(1);
}
