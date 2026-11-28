// error: retained storage may have a self-relative link to a removed element
struct Link { next: Node&<u32>? }
struct Node { links: Link[2] = [Link {}; 2] }

fn main() {
    var nodes: Node[>..] = [Node {}; 2];
    var i: i64 = 0;
    fn advance() -> i64 { i = 1; return 0; }
    nodes[i].links[advance()].next .= nodes[i];
    nodes.pop();
}
