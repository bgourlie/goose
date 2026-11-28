// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
struct Trim {}
var nodes: Node[>..] = [Node {}; 2];

fn format(out: u8[>..]&, _: Trim) { nodes.pop(); out.push(88); }
fn show_three() { print([Trim {}; 3]); }

fn main() {
    nodes[0].next .= nodes[1];
    nodes.append([Node {}; 2]);
    show_three();
}
