// xfail: accepts-invalid
// error: a shrink could remove an element that a self-relative reference still names
// When stop is false, the break delivers the linked result to the conversion (§5.2).
struct Node { next: Node&<u32>? }
fn linked() -> Node[] {
    var nodes: Node[] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    return nodes;
}
fn make(stop: bool) -> Node[] {
    loop {
        defer { if stop { abort("stop"); } }
        break linked();
    }
}
fn main() {
    var nodes: Node[>..<] = make(false);
    print(nodes.len);
}
