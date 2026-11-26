// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
fn clear(n: Node&) { n.next .= null; }

fn trim(index: i64) {
    var nodes: Node[>..] = [Node {}, Node {}, Node {}];
    {
        let first .= nodes[0];
        let other .= nodes[index];
        first.next .= nodes[2];
        other.next .= nodes[2];
        clear(other);
    }
    nodes.pop_n(1);
}

fn main() { trim(1); }
