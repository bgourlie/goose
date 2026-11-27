// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }

fn pair() -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    nodes[0].next .= nodes[2];
    var shorter: Node[..] = [Node {}];
    var views: (Node[..]&)[2] = [nodes, shorter];
    var offsets: i64[..] = [0, 1];
    offsets.pop_n(1);
    views[offsets.len - 1].resize(views[offsets.cap - 1].len);
    return nodes;
}

fn main() { let live: Node[] = pair(); print(live.len); }
