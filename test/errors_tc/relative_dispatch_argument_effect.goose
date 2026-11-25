// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
enum Action { One, Two }

fn choose(nodes: Node[>..]&) -> Action {
    nodes[0].next .= nodes[1];
    return Action.One;
}

fn consume(action: Action.One) {}
fn consume(action: Action.Two) {}

fn trim(keep: i64) {
    var nodes: Node[>..] = [Node {}, Node {}];
    consume(choose(nodes));
    nodes.resize(keep);
}

fn main() { trim(2); }
