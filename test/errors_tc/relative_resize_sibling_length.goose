// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
struct Bag { shorter: Node[..2], nodes: Node[>..] }

fn main() {
    var bag = Bag { shorter: [Node {}], nodes: [Node {}, Node {}] };
    bag.nodes[0].next .= bag.nodes[1];
    let other .= bag;
    bag.nodes.resize(other.shorter.len);
}
