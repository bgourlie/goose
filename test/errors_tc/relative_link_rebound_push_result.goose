// error: retained storage may have a self-relative link to a removed element
struct Node { value: i64 = 0, next: Node&<u32>? }

fn main() {
    var nodes: Node[>..] = [Node {}, Node {}];
    {
        let previous .= nodes[1];
        var current .= nodes.push(Node {});
        current .= nodes[0];
        current.next .= previous;
    }
    nodes.pop_n(2);
}
