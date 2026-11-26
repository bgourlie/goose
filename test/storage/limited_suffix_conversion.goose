struct Node { next: Node&<u32>? }

fn empty(refill: bool) -> Node[..] {
    var nodes: Node[..] = [Node {}; 2];
    nodes[0].next .= nodes[1];
    {
        let old .= nodes[0];
        nodes.clear();
        assert(old.next != null);
    }
    if refill { nodes.push(Node {}); }
    return nodes;
}

fn main() {
    let none: Node[] = empty(false);
    assert(none.len == 0);
    let one: Node[] = empty(true);
    assert(one.len == 1 && one[0].next == null);
    print("ok");
}
