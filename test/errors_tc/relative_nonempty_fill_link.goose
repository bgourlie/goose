// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
struct List { header: Node[..2], nodes: Node[>..] }

fn invoke<F>() { F(); }
fn linked(first: Node&) -> Node {
    invoke() { return Node { next: first } from linked; };
    Node {}
}
fn main() {
    var list = List { header: [], nodes: [Node {}] };
    list.header = [linked(list.nodes[0]); 1];
    list.nodes.clear();
}
