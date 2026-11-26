// error: cannot call trim, which shrinks nodes: retained storage may have a self-relative link
struct Node { next: Node&<u32>? }
var nodes: Node[>..] = [Node {}, Node {}];
fn link() -> i64 { nodes[0].next .= nodes[1]; return 0; }
fn trim() -> i64 { nodes.pop_n(1); return nodes.len; }
struct Box<T> { first: i64 = link(), value: T }

fn main() { let box = Box { value: trim() }; print(box.value); }
