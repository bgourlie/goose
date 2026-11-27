// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }

fn next(i: i64&) -> i64 { let old = i; i = i + 1; return old; }

fn pair() -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    nodes[0].next .= nodes[2];
    var shorter: Node[..] = [Node {}];
    var views: (Node[..]&)[2] = [nodes, shorter];
    var i = 0;
    views[0 + next(i)].resize(views[0 + next(i)].len);
    return nodes;
}

fn main() { let live: Node[] = pair(); print(live.len); }
