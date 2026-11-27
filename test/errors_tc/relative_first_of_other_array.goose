// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
struct List { heads: Node[2], nodes: Node[>..] }

fn trim(i: i64) {
    var list = List { heads: [Node {}, Node {}], nodes: [Node {}] };
    list.heads[i].next .= list.nodes[0];
    list.nodes.pop_n(1);
}

fn main() { trim(1); }
