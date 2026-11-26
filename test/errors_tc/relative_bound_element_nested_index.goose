// error: retained storage may have a self-relative link to a removed element
struct Links { next: Node&<u32>? }
struct Node { links: Links[2] = [Links {}, Links {}] }

fn main() {
    var nodes: Node[>..] = [Node {}, Node {}];
    {
        let first .= nodes[0];
        first.links[0].next .= nodes[1];
        first.links[1].next .= null;
    }
    nodes.pop_n(1);
}
