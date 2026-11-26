// error: cannot call trim, which shrinks nodes: retained storage may have a self-relative link
struct Node { next: Node&<u32>? }
struct Reset {}
var nodes: Node[>..] = [Node {}, Node {}];

fn format(out: u8[>..]&, r: Reset) { nodes.clear(); }
fn format(out: u8[>..]&, r: Reset, value: i64) { print(value); }
fn trim() -> i64 { nodes.pop_n(1); return nodes.len; }

fn main() {
    var out: u8[>..] = [];
    nodes[0].next .= nodes[1];
    // The three-argument user overload evaluates trim before entering its body.
    format(out, Reset {}, trim());
}
