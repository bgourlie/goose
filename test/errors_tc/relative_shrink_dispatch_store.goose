// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

enum Action { Link, Clear }
fn edit(action: Action.Link, nodes: Node[>..]&) { nodes[0].next .= nodes[1]; }
fn edit(action: Action.Clear, nodes: Node[>..]&) { nodes.clear(); }

fn trim(action: Action, keep: i64) {
    var nodes: Node[>..] = [Node {}, Node {}];
    edit(action, nodes);
    nodes.resize(keep);
}

fn main() { trim(Action.Link, 2); }
