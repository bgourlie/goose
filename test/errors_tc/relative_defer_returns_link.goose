// xfail: accepts-invalid
// error: a shrink could remove an element that a self-relative reference still names
// When stop is false, the defer completes and the conversion receives the linked result (§5.2).
struct Node { next: Node&<u32>? }
fn make(stop: bool) -> Node[] {
    var nodes: Node[] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    defer { if stop { abort("stop"); } }
    return nodes;
}
fn main() {
    var nodes: Node[>..<] = make(false);
    print(nodes.len);
}
