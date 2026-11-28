// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
fn trim(flag: bool) {
    var rows: Node[>..] = [Node {}; 2];
    rows[0].next .= rows[1];
    rows.push(Node {});
    const count: i64 = if flag { 1 } else { 2 };
    for i in count { rows.pop(); }
}
fn main() { trim(false); }
