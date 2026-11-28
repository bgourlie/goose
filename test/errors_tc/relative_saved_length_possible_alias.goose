// error: the array shrink relies on growth leaving the measured array's length unchanged
struct Node { next: Node&<u32>? }

fn trim(nodes: Node[>..]&, scratch: Node[>..]&) {
    const size = nodes.len;
    scratch.push(Node {});
    scratch[0].next .= scratch[2];
    nodes.resize(size);
}

fn choose(flag: bool) {
    var a: Node[>..] = [Node {}, Node {}];
    var b: Node[>..] = [Node {}, Node {}];
    a[0].next .= a[1];
    let target: Node[>..]& = if flag { a } else { b };
    trim(a, target);
}

fn main() { choose(true); }
