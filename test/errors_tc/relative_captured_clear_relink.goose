// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn rebuild(nodes: Node[>..]&) {
    fn reset() {
        nodes.clear();
        nodes.push(Node {});
        nodes.push(Node {});
        nodes[0].next .= nodes[1];
    }
    reset();
}

fn trim(keep: i64) {
    var nodes: Node[>..] = [Node {}, Node {}];
    rebuild(nodes);
    nodes.resize(keep);
}
fn main() { trim(2); }
