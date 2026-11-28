// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn trim(flag: bool) {
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    nodes.append([Node {}, Node {}]);
    { defer { if flag { nodes[0].next .= nodes[3]; nodes.push(Node {}); } } }
    nodes.pop_n(2);
}

fn main() { trim(false); }
