// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
fn main() {
    var rows: Node[>..] = [Node {}; 2];
    rows[0].next .= rows[1];
    rows.push(Node {});
    let data = [1, 2, 3];
    for x in data[1..3] { rows.pop(); }
}
