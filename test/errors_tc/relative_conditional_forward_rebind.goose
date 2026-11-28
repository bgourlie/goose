// error: retained storage may have a self-relative link to a removed element
struct Node { tag: i64 = 0, next: Node&<u32>? }
fn trim(flag: bool) {
    var nodes: Node[>..] = [Node {}; 3];
    nodes[1].next .= if flag { nodes[0] } else { nodes[2] };
    nodes.pop();
}
fn main() { trim(false); }
