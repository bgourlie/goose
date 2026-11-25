// error: a shrink could remove an element that a self-relative reference still names
struct Node { next: Node&<u32>? }
struct Stop { flag: bool }
fn format(out: u8[>..]&, stop: Stop) { abort("stop"); }
fn make(stops: Stop[:]) -> Node[] {
    var nodes: Node[] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    defer { print(stops); }
    return nodes;
}
fn main() {
    let empty: Stop[0] = [];
    var nodes: Node[>..<] = make(empty);
    print(nodes.len);
}
