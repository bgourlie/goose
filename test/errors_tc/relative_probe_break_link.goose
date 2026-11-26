// error: cannot pop_n nodes: retained storage may have a self-relative link
struct Node { next: Node&<u32>? }
var nodes: Node[>..] = [Node {}, Node {}];
fn link() -> i64 { nodes[0].next .= nodes[1]; return 0; }
struct Box<T> { first: i64 = link(), value: T }

fn choose(flag: bool) {
    block {
        let box = Box { value: if flag { break; } else { 17 } };
        nodes.clear();
        nodes.push(Node {});
    }
    nodes.pop_n(1);
}
fn main() { choose(true); }
