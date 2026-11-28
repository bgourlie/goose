// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
fn main() {
    var a: Node[>..] = [Node {}; 2];
    for i in 1 { a[0].next .= a[1]; }
    a.pop();
}
