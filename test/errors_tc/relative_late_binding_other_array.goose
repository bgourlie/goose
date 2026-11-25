// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn clear_one(first: Node[>..]&, second: Node[>..]&, take_first: bool) {
    let alias: Node[>..]&;
    if take_first { alias .= first; } else { alias .= second; }
    alias.clear();
}

fn main() {
    var a: Node[>..] = [Node {}, Node {}];
    var b: Node[>..] = [];
    a[0].next .= a[1];
    clear_one(a, b, false);
    a.pop_n(1);
}
