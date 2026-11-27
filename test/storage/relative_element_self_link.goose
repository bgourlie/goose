struct Links { next: Node&<u32>? }
struct Node { value: i64 = 0, links: Links = Links {} }

fn trim(i: i64) {
    var nodes: Node[>..] = [Node {}, Node {}];
    {
        let n .= nodes[i];
        let alias .= n;
        alias.links.next .= n;
        assert(n.links.next .== nodes[i]);
    }
    nodes.pop_n(1);
    assert(nodes.len == 1);
    if i == 0 { assert(nodes[0].links.next .== nodes[0]); }
    else { assert(nodes[0].links.next == null); }
}

fn main() {
    trim(0);
    trim(1);
    print("ok");
}
