// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }

fn pair(trim: bool) -> Node[..] {
    var nodes: Node[..] = [Node {}; 2];
    let target: Node& = block {
        if trim {
            defer { nodes.pop_n(1); }
            break nodes[1];
        }
        nodes[0]
    };
    nodes[0].next .= target;
    return nodes;
}

fn main() { let live: Node[] = pair(true); print(live.len); }
