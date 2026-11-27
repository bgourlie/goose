// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }

fn pair() -> Node[..] {
    var nodes: Node[..] = [Node {}, Node {}];
    var shorter: Node[..] = [Node {}];
    nodes[0].next .= nodes[1];
    var views: (Node[..]&)[2] = [nodes, shorter];
    views[0].resize(views[1].len);
    return nodes;
}

fn main() { let live: Node[] = pair(); print(live.len); }
