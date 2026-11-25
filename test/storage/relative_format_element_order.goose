struct Node { next: Node&<u32>? }
struct Reset {}
struct Trim {}
struct Link {}
struct Step { reset: Reset, trim: Trim, link: Link }
var nodes: Node[>..] = [Node {}, Node {}];
var calls: i64 = 0;

fn format(out: u8[>..]&, r: Reset) {
    nodes.clear();
    nodes.push(Node {});
    nodes.push(Node {});
}
fn format(out: u8[>..]&, t: Trim) { nodes.pop_n(1); nodes.push(Node {}); }
fn format(out: u8[>..]&, l: Link) { nodes[0].next .= nodes[1]; calls += 1; }

fn main() {
    nodes[0].next .= nodes[1];
    let steps = [Step { reset: Reset {}, trim: Trim {}, link: Link {} }; 2];
    let rendered = str(steps);
    assert(rendered.len > 0 && calls == 2 && nodes[0].next .== nodes[1]);
    let empty: Trim[0] = [];
    assert(str(empty) == "[]" && nodes[0].next .== nodes[1]);
    let resets = [Reset {}];
    let cleared = str(resets);
    nodes.pop_n(1);
    assert(cleared.len > 0 && nodes.len == 1);
    print("ok");
}
