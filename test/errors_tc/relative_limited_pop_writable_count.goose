// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }
let count = 0;

fn change(n: i64&) { n = 1; }
fn pair() -> Node[..] {
    var nodes: Node[..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    nodes.pop_n(count);
    return nodes;
}

fn main() {
    change(count);
    let nodes: Node[] = pair();
    print(nodes.len);
}
