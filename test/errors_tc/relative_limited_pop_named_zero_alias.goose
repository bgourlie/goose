// error: bound to a writable reference
struct Node { next: Node&<u32>? }
let count = 0;

fn pop(nodes: Node[..]&) { nodes.pop_n(count); }
fn change(value: i64&) { value = 1; }
fn pair() -> Node[..] {
    var nodes: Node[..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    pop(nodes);
    return nodes;
}

fn main() {
    let live: Node[] = pair();
    change(count);
    print(live.len);
}
