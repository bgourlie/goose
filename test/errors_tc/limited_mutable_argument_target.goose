// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }
fn first(n: Node&, ignored: i64) -> Node& { n }

fn pair() -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    var last .= nodes[2];
    nodes.pop_n(1);
    nodes[0].next .= first(last, block { last .= nodes[1]; 0 });
    return nodes;
}

fn main() { let live: Node[] = pair(); print(live.len); }
