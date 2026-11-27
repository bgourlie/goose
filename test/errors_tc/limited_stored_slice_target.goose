// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }

fn from_view(view: Node[:]) -> Node { Node { next: view[0] } }
fn linked() -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    let tail = nodes[2..];
    nodes.pop_n(1);
    nodes[0] = from_view(tail);
    return nodes;
}

fn main() { let live: Node[] = linked(); print(live.len); }
