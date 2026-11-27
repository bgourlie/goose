// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn trim(a: Node[>..]&, b: Node[>..]&) {
    const size = a.len;
    b.resize(size);
}

fn main() {
    var a: Node[>..] = [Node {}];
    var b: Node[>..] = [Node {}, Node {}];
    b[0].next .= b[1];
    trim(a, b);
}
