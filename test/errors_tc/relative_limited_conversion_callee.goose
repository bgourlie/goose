// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }
fn trim(xs: Node[..]&) { xs.pop_n(1); }
fn pair(shorter: bool) -> Node[..] {
    var nodes: Node[..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    if shorter { trim(nodes); }
    return nodes;
}
fn main() { let prefix: Node[] = pair(true); print(prefix.len); }
