// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
struct Reset {}
enum Action { Resetting { action: Reset }, Idle }
var nodes: Node[>..] = [Node {}, Node {}];
var keep: i64 = 2;

fn format(out: u8[>..]&, reset: Reset) { nodes.clear(); }
fn show(action: Action) { print(action); }

fn main() {
    nodes[0].next .= nodes[1];
    show(Action.Idle);
    nodes.resize(keep);
}
