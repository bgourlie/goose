// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
struct List { spare: Node, tail: Node[>..] }
fn linked() -> Node[] {
    var xs: Node[] = [Node {}, Node {}];
    xs[0].next .= xs[1];
    return xs;
}
fn make() -> List {
    List { spare: Node {}, tail: linked() }
}
fn main() {
    var list = make();
    list.spare = Node {};
    list.tail.pop_n(1);
}
