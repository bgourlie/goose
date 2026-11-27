struct Links { next: Node&<u32>? }
struct Node { links: Links = Links {}, extra: Links[2] = [Links {}, Links {}] }

fn connect(n: Node&, target: Node&) { n.links.next .= target; }
fn clear_links(links: Links&) { links.next .= null; }
fn as_node(n: Node&) -> Node& { n }

fn relay(n: Node&, target: Node&) { connect(n, target); }
fn connect_link(link: Links&, target: Node&) { link.next .= target; }
fn connect_extra(n: Node&, target: Node&, j: i64) { connect_link(n.extra[j], target); }

fn clear_indexed(index: i64, j: i64) {
    var nodes: Node[>..] = [Node {}, Node {}, Node {}];
    relay(nodes[index], nodes[2]);
    assert(nodes[index].links.next .== nodes[2]);
    nodes[index].links.next .= null;
    connect_extra(nodes[index], nodes[2], j);
    nodes[index].extra = [Links {}, Links {}];
    nodes.pop_n(1);
    assert(nodes.len == 2 && nodes[index].links.next == null);
}

fn clear_pair(index: i64, direct: bool) {
    var nodes: Node[>..] = [Node {}, Node {}, Node {}];
    {
        let first .= nodes[index];
        let alias .= first;
        let other .= nodes[1];
        connect(first, nodes[2]);
        other.links = Links { next: nodes[2] };
        if direct { first.links.next .= null; }
        else { clear_links(as_node(alias).links); }
        assert(other.links.next .== nodes[2]);
        other.extra[0].next .= nodes[2];
        other.extra = [Links {}, Links {}];
        defer { other.links.next .= null; }
    }
    nodes.pop_n(1);
    assert(nodes.len == 2 && nodes[0].links.next == null && nodes[1].links.next == null);
}

fn clear_each() {
    var nodes: Node[>..] = [Node {}, Node {}, Node {}];
    for i in 2 {
        let slot .= nodes[i];
        slot.links.next .= nodes[2];
        slot.links = Links {};
    }
    for &slot in nodes[0..2] {
        fn connect_slot() { slot.links.next .= nodes[2]; }
        connect_slot();
        slot.links.next .= null;
    }
    nodes.pop_n(1);
    assert(nodes.len == 2);
}

fn main() {
    clear_indexed(1, 0);
    clear_pair(0, true);
    clear_pair(0, false);
    clear_each();
    print("ok");
}
