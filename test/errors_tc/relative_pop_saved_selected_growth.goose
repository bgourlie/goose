// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn trim(first: bool) {
    var a: Node[>..] = [Node {}, Node {}];
    var b: Node[>..] = [Node {}, Node {}, Node {}];
    a[0].next .= a[1];
    b[0].next .= b[2];
    let selected: Node[>..]& = if first { a } else { b };
    const count = selected.len;
    b.push(Node {});
    selected.pop_n(count);
}

fn main() { trim(true); }
