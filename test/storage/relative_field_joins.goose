struct Node { value: i64 }
struct Slot { link: Node&<u32>? }
struct Header { left: Slot, leftmost: Slot }
struct List { header: Header, spare: Slot, nodes: Node[>..] }

fn empty_header() -> Header { Header { left: Slot {}, leftmost: Slot {} } }

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
    for whole in [true, false] {
        branch_overwrites(whole);
        joined_reference(whole);
    }
    print("ok");
}
