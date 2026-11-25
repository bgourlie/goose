// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn visit(amount: i64) -> i64 {
    var nodes: Node[>..] = [Node {}, Node {}];
    fn finish() {
        nodes[0].next .= nodes[1];
        return 7 from visit;
    }
    defer { nodes.pop_n(amount); }
    finish();
    return 0;
}

fn main() { print(visit(0)); }
