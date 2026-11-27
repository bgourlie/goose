// error: retained storage may have a self-relative link to a removed element
struct Node { value: i64 = 0, next: Node&<u32>? }
fn advance(i: i64&) -> i64 { let old = i; i = i + 1; return old; }

fn main() {
    var nodes: Node[>..] = [Node {}, Node {}];
    var i = 0;
    nodes[advance(i)].next .= nodes[advance(i)];
    nodes.pop_n(1);
}
