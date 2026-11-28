// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn change(first: Node[>..]&, second: Node[>..]&) {
    first.push(Node {});
    second.pop();
}

fn main() {
    var a: Node[>..] = [];
    var b: Node[>..] = [Node {}, Node {}];
    b[0].next .= b[1];
    change(a, b);
}
