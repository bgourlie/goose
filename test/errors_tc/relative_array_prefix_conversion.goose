// error: a self-relative link may name the source array itself
struct Node { owner: Node[]&<u32>? }

fn linked() -> Node[] {
    var nodes: Node[] = [Node {}];
    nodes[0].owner .= nodes;
    return nodes;
}

fn forward() -> Node[] { linked() }

fn main() {
    var received: Node[>..] = forward();
    print(received.len);
}
