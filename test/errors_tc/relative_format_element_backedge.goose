// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
struct Trim {}
struct Link {}
struct Step { trim: Trim, link: Link }
var nodes: Node[>..] = [Node {}, Node {}];
var keep: i64 = 2;

fn format(out: u8[>..]&, t: Trim) { nodes.resize(keep); }
fn format(out: u8[>..]&, l: Link) { nodes[0].next .= nodes[1]; }

fn show(steps: Step[:]) { print(steps); }

fn main() {
    let steps = [Step { trim: Trim {}, link: Link {} }; 2];
    show(steps);
}
