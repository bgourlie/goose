// error: cannot pop_n other: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn main() {
    var nodes: Node[>..] = [Node {}, Node {}];
    var other: Node[>..] = [Node {}, Node {}];
    other[0].next .= other[1];
    var alias .= nodes;
    alias.clear();
    alias .= other;
    other.pop_n(1);
}
