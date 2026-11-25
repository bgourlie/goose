// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn visit<F>(xs: Node[>..]&) {
    xs.clear();
    xs.push(Node {});
    xs.push(Node {});
    F(xs);
    xs.pop_n(1);
}

fn main() {
    var xs: Node[>..] = [];
    visit(xs) { it[0].next .= it[1]; };
}
