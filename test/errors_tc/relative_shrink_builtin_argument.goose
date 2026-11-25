// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn count(nodes: Node[>..]&, amount: i64) -> i64 {
    nodes[0].next .= nodes[1];
    return amount;
}

fn trim(amount: i64) {
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes.pop_n(count(nodes, amount));
}

fn main() { trim(0); }
