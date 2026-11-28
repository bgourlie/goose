struct Node { next: Node&<u32>? }
struct Trim {}
var nodes: Node[>..] = [Node {}; 2];
fn format(out: u8[>..]&, _: Trim) { nodes.pop(); out.push(88); }

fn connect(a: Node[>..]&) { a[0].next .= a[1]; }
fn unused_write(a: Node[>..]&) {
    for i in 2..1 { connect(a); }
    for i in 0 { a[0].next .= a[1]; }
}
fn unused_pop(a: Node[>..]&) {
    fn trim() { a.pop(); }
    for i in 0 { trim(); }
    for i in 0 { defer a.pop(); }
}
fn main() {
    var a: Node[>..] = [Node {}; 2];
    unused_write(a);
    a.pop();
    assert(a.len == 1);
    nodes[0].next .= nodes[1];
    unused_pop(nodes);
    var vals = [Trim {}];
    print(vals[0..0]);
    const empty = vals[0..0];
    print(empty);
    for v in empty { nodes.pop(); }
    let value: i64;
    fn initialize() {
        for i in 0 { return; }
        value = 5;
    }
    initialize();
    assert(value == 5 && nodes.len == 2);
    print("ok");
}
