// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
struct Trim {}
var nodes: Node[>..] = [Node {}; 2];
fn format(out: u8[>..]&, _: Trim) { nodes.pop(); out.push(88); }
fn main() {
    nodes[0].next .= nodes[1];
    var vals = [Trim {}];
    var view = vals[0..0];
    view = vals[0..1];
    print(view);
}
