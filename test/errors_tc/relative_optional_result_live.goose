// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
struct List { head: Node, nodes: Node[>..] }
fn maybe_head(head: Node&, skip: bool) -> Node&? {
    if skip { return null; }
    return head;
}
fn run(flag: bool) {
    var list = List { head: Node {}, nodes: [Node {}] };
    {
        let slot: Node&? = if flag { list.nodes[0] } else { maybe_head(list.head, flag) };
        if slot { slot.next .= list.nodes[0]; }
    }
    list.nodes.clear();
}
fn main() { run(false); }
