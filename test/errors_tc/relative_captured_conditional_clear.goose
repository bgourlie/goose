// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn clear_one(first: Node[>..]&, second: Node[>..]&, take_first: bool) {
    fn reset() {
        if take_first { first.clear(); } else { second.clear(); }
    }
    reset();
}

fn main() {
    var a: Node[>..] = [Node {}, Node {}];
    var b: Node[>..] = [];
    a[0].next .= a[1];
    clear_one(a, b, false);
    a.pop_n(1);
}
