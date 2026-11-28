struct Node { next: Node&<u32>? }

fn link_and_resize(nodes: Node[>..]&, i: i64, j: i64) {
    nodes[i].next .= nodes[j];
    nodes.resize(4);
}
fn wrap(nodes: Node[>..]&, i: i64, j: i64) { link_and_resize(nodes, i, j); }
fn grow_and_link(nodes: Node[>..]&) {
    nodes.push(Node {});
    wrap(nodes, 0, 3);
}
fn main() {
    var four: Node[>..] = [Node {}; 4];
    link_and_resize(four, 0, 3);
    assert(four.len == 4 && four[0].next .== four[3]);
    var three: Node[>..] = [Node {}; 3];
    grow_and_link(three);
    assert(three.len == 4 && three[0].next .== three[3]);
    var five: Node[>..] = [Node {}; 5];
    {
        defer wrap(five, 1, 3);
        five.pop();
    }
    assert(five.len == 4 && five[1].next .== five[3]);
    print("ok");
}
