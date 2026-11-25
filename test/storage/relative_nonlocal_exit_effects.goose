struct Node { next: Node&<u32>? }

fn visit(nodes: Node[>..]&, early: bool) {
    if early { return from separate; }
    nodes[0].next .= nodes[1];
}
fn separate(early: bool) {
    var nodes: Node[>..] = [Node {}, Node {}];
    defer { nodes.pop_n(1); }
    visit(nodes, early);
    nodes.clear();
    nodes.push(Node {});
}

fn reset(nodes: Node[>..]&, early: bool) {
    if early {
        nodes.clear();
        nodes.push(Node {});
        return from overwritten;
    }
}
fn forward(nodes: Node[>..]&, early: bool) { reset(nodes, early); }
fn overwritten(early: bool) {
    var nodes: Node[>..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    defer { nodes.pop_n(1); }
    forward(nodes, early);
    nodes.clear();
    nodes.push(Node {});
}

struct Entry { n: i64, next: Entry&<u32>? }
fn leave() -> i64 { return from install; }
fn init(other: Entry&, early: bool) -> Entry {
    return Entry { n: if early { leave() } else { 42 }, next: other };
}
fn install(entries: Entry[>..]&, early: bool) {
    entries[0] = init(entries[1], early);
    assert(entries[0].next .== entries[1]);
    entries.clear();
    entries.push(Entry { n: 42 });
    entries.push(Entry { n: 2 });
}
fn main() {
    for early in [true, false] {
        separate(early);
        overwritten(early);
        var entries: Entry[>..] = [Entry { n: 1 }, Entry { n: 2 }];
        install(entries, early);
        entries.pop_n(1);
        assert(entries.len == 1 && entries[0].next == null);
    }
    print("ok");
}
