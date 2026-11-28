// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
struct Add {}
var nodes: Node[>..] = [Node {}; 2];
fn format(out: u8[>..]&, _: Add) { nodes.push(Node {}); out.push(88); }
fn show(items: Add[..2]&) { print(items); }
fn main() {
    nodes[0].next .= nodes[1];
    var empty: Add[..2] = [];
    show(empty);
    nodes.pop();
}
