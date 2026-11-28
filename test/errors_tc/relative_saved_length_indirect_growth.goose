// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
struct Holder { target: Node[>..]& }

fn grow(holder: Holder&) { holder.target.push(Node {}); }
fn forward(holder: Holder&) { grow(holder); }
fn trim(nodes: Node[>..]&, holder: Holder&) {
    const size = nodes.len;
    forward(holder);
    nodes.resize(size);
}

fn choose(flag: bool) {
    var a: Node[>..] = [Node {}, Node {}];
    var b: Node[>..] = [Node {}, Node {}];
    a[0].next .= a[1];
    let selected: Node[>..]& = if flag { a } else { b };
    var holder = Holder { target: selected };
    trim(a, holder);
}

fn main() { choose(true); }
