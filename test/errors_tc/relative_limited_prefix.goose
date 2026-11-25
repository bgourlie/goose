// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }

fn limited() -> Node[..] {
    var nodes: Node[..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    nodes.pop_n(1);
    return nodes;
}

fn main() {
    let prefix: Node[] = limited();
    print(prefix.len);
}
