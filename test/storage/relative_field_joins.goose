struct Node { value: i64 }
struct Slot { link: Node&<u32>? }
struct Header { left: Slot, leftmost: Slot }
struct List { header: Header, spare: Slot, nodes: Node[>..] }

fn empty_header() -> Header { Header { left: Slot {}, leftmost: Slot {} } }
fn identity(slot: Slot&) -> Slot& { slot }
fn forwarded(h: Header&) -> Slot& { identity(h.leftmost) }
fn pair(a: Slot&, b: Slot&) -> Slot&, Slot& { return a, b; }

fn returned_fields() {
    var list = List { header: empty_header(), spare: Slot {}, nodes: [Node { value: 1 }] };
    list.header.left.link .= list.nodes[0];
    list.header.leftmost.link .= list.nodes[0];
    identity(list.header.left).link .= null;
    forwarded(list.header).link .= null;
    list.nodes.clear();
    list.nodes.push(Node { value: 2 });
    list.header.left.link .= list.nodes[0];
    list.spare.link .= list.nodes[0];
    {
        let a, b .= pair(list.header.left, list.spare);
        a.link .= null;
        b.link .= null;
    }
    list.nodes.clear();
}

fn reset(list: List&, whole: bool) {
    if whole { list.header = empty_header(); }
    else {
        list.header.left.link .= null;
        list.header.leftmost.link .= null;
    }
}

fn reset_on_exit(list: List&, whole: bool) {
    if whole { list.header = empty_header(); return; }
    list.header.left.link .= null;
    list.header.leftmost.link .= null;
}

fn reset_and_clear(list: List&, whole: bool) {
    if whole {
        list.header = empty_header();
        list.nodes.clear();
    } else {
        list.header.left.link .= null;
        list.header.leftmost.link .= null;
        list.nodes.clear();
    }
}

fn branch_overwrites(whole: bool) {
    var list = List { header: empty_header(), spare: Slot {}, nodes: [Node { value: 1 }] };
    list.header.left.link .= list.nodes[0];
    list.header.leftmost.link .= list.nodes[0];
    reset(list, whole);
    list.nodes.clear();
    list.nodes.push(Node { value: 2 });
    list.header.left.link .= list.nodes[0];
    list.header.leftmost.link .= list.nodes[0];
    reset_on_exit(list, whole);
    list.nodes.clear();
    list.nodes.push(Node { value: 3 });
    list.header.left.link .= list.nodes[0];
    reset_and_clear(list, whole);
}

fn joined_reference(left: bool) {
    var list = List { header: empty_header(), spare: Slot {}, nodes: [Node { value: 1 }] };
    {
        let slot: Slot& = if left { list.header.left } else { list.header.leftmost };
        slot.link .= list.nodes[0];
    }
    list.header = empty_header();
    list.nodes.clear();
}

fn main() {
    returned_fields();
    for whole in [true, false] {
        branch_overwrites(whole);
        joined_reference(whole);
    }
    print("ok");
}
