// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
struct List { head: Node, nodes: Node[>..] }

fn link(dst: Node&, src: Node&) { dst.next .= src; }
fn indirect(tail: Node&, src: Node&) {
    let other .= tail.next;
    if other { link(other, src); }
}

fn main() {
    var list = List { head: Node {}, nodes: [Node {}, Node {}] };
    list.nodes[0].next .= list.head;
    indirect(list.nodes[0], list.nodes[1]);
    list.nodes.clear();
}
