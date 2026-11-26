// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }
fn trim_at_exit(nodes: Node[..]&) { defer { nodes.pop_n(1); } }
fn pair() -> Node[..] {
    var nodes: Node[..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    trim_at_exit(nodes);
    return nodes;
}
fn main() { let prefix: Node[] = pair(); print(prefix.len); }
