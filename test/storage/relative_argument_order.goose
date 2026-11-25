struct Node { next: Node&<u32>? }
struct Pair<T> { first: T, second: T }
enum Action { One, Two }

fn remove(nodes: Node[>..]&) -> i64 { nodes.pop_n(1); return nodes.len; }
fn link(nodes: Node[>..]&) -> i64 { nodes[0].next .= nodes[1]; return nodes.len; }
fn choose(nodes: Node[>..]&) -> Action { link(nodes); return Action.One; }
fn consume(first: i64, second: i64) { assert(first == 2 && second == 2); }
fn dispatch(first: i64, action: Action.One) { assert(first == 2); }
fn dispatch(first: i64, action: Action.Two) { assert(first == 2); }

fn main() {
    var nodes: Node[>..] = [Node {}, Node {}, Node {}];
    consume(remove(nodes), link(nodes));
    assert(nodes[0].next .== nodes[1]);
    nodes = [Node {}, Node {}, Node {}];
    remove(nodes).consume(link(nodes));
    assert(nodes[0].next .== nodes[1]);
    nodes = [Node {}, Node {}, Node {}];
    dispatch(remove(nodes), choose(nodes));
    assert(nodes[0].next .== nodes[1]);
    nodes = [Node {}, Node {}, Node {}];
    let pair = Pair { first: remove(nodes), second: link(nodes) };
    assert(pair.first == 2 && pair.second == 2 && nodes[0].next .== nodes[1]);
    print("ok");
}
