struct Node { next: Node&<u32>? }

fn visit<F>(xs: Node[>..]&) {
    xs.clear();
    F();
    xs.push(Node {});
    xs.pop_n(1);
}

fn reset<F>(xs: Node[>..]&) { F(xs); }

fn main() {
    var xs: Node[>..] = [Node {}, Node {}];
    xs[0].next .= xs[1];
    visit(xs) { print("observed"); };
    assert(xs.len == 0);

    xs.push(Node {});
    xs.push(Node {});
    xs[0].next .= xs[1];
    reset(xs) { it.clear(); };
    xs.push(Node {});
    xs.pop_n(1);
    assert(xs.len == 0);
}
