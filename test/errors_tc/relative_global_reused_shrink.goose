// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
var xs: Node[>..] = [Node {}];
fn trim() { xs.pop_n(1); }
fn main() {
    trim();
    xs.push(Node {});
    xs.push(Node {});
    xs[0].next .= xs[1];
    trim();
}
