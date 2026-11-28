// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
struct List { rows: Node[>..] }
fn main() {
    var list = List { rows: [Node {}; 4] };
    list.rows = [Node {}; 2];
    list.rows[0].next .= list.rows[1];
    list.rows.pop();
}
