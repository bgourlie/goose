// error: cannot prove the array has at most 4 elements on entry
struct Node { next: Node&<u32>? }
var nodes: Node[>..] = [Node {}; 4];
fn link_and_resize(a: Node[>..]&, i: i64, j: i64) {
    a[i].next .= a[j];
    a.resize(4);
}
export fn trim(i: i64, j: i64) { link_and_resize(nodes, i, j); }
fn main() { trim(0, 3); }
