// error: while the limited-array conversion
struct Node { next: Node&<u32>? }
let count = 0;

fn trim(nodes: Node[..]&) { nodes.resize(count); }
fn change(n: i64&) { n = 1; }
fn pair() -> Node[..] {
    var nodes: Node[..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    trim(nodes);
    return nodes;
}

fn main() {
    let live: Node[] = pair();
    change(count);
    print(live.len);
}
