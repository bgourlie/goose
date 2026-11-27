// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn clear(i: i64, j: i64) {
    var nodes: Node[>..] = [Node {}, Node {}, Node {}];
    {
        let original .= nodes[i];
        var current .= nodes[i];
        defer {
            original.next .= nodes[2];
            current.next .= null;
        }
        let change .= i;
        change = j;
        current .= nodes[i];
    }
    nodes.pop_n(1);
}

fn main() { clear(0, 0); }
