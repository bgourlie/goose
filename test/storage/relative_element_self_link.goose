struct Links { next: Node&<u32>?, selected: i64&<u32>?, payload: i64 = 7 }
struct Node { value: i64 = 0, links: Links = Links {} }

fn trim(i: i64) {
    var nodes: Node[>..] = [Node {}, Node {}];
    {
        let n .= nodes[i];
        let alias .= n;
        alias.links.next .= n;
        alias.links.selected .= n.links.payload;
        assert(n.links.next .== nodes[i]);
    }
    nodes.pop_n(1);
    assert(nodes.len == 1);
    if i == 0 { assert(nodes[0].links.next .== nodes[0] && nodes[0].links.selected .== nodes[0].links.payload); }
    else { assert(nodes[0].links.next == null); }
}

fn mark(n: Node&) { n.links.next .= n; n.links.selected .= &n.value; }

fn mark_each(helper: bool) {
    var nodes: Node[>..] = [Node {}, Node {}, Node {}];
    for &n in nodes {
        if helper { mark(n); }
        else { n.links.next .= n; n.links.selected .= n.value; }
    }
    nodes.pop_n(1);
    assert(nodes.len == 2 && nodes[0].links.next .== nodes[0] && nodes[1].links.next .== nodes[1]);
    assert(nodes[0].links.selected .== nodes[0].value && nodes[1].links.selected .== nodes[1].value);
}

fn main() {
    trim(0);
    trim(1);
    mark_each(false);
    mark_each(true);
    print("ok");
}
