// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>?, n: i64 = 0 }

fn pair() -> Node[..] {
    var nodes: Node[..] = [Node {}; 5];
    nodes.append([Node { next: nodes[4], n: block { nodes.pop_n(4); 1 } }; 2]);
    return nodes;
}

fn main() { let live: Node[] = pair(); print(live.len); }
