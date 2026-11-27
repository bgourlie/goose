// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn trim(i: i64) {
    var nodes: Node[>..] = [Node {}, Node {}, Node {}];
    fn reset() { nodes[i].next .= null; }
    nodes[i].next .= nodes[2];
    let change .= i;
    change = 1;
    reset();
    nodes.pop_n(1);
}

fn main() { trim(0); }
