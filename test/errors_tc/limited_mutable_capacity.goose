// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }

fn pair() -> Node[..] {
    let capacity = 2;
    var alias .= capacity;
    alias = 3;
    var nodes: Node[..] = [..capacity];
    nodes = [Node {}; 3];
    let last .= nodes[2];
    nodes = [Node {}; 2];
    nodes[0].next .= last;
    return nodes;
}

fn main() { let live: Node[] = pair(); print(live.len); }
