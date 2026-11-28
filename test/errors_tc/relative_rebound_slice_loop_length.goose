// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
fn main() {
    var rows: Node[>..] = [Node {}; 2];
    rows[0].next .= rows[1];
    rows.push(Node {});
    let data = [1, 2];
    var view = data[0..1];
    for x in view {
        rows.pop();
        view = data[..];
    }
}
