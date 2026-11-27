// error: a self-relative link may name a slot beyond the live length
struct Node { next: Node&<u32>? }
enum Size { Short, Full }

fn replacement(size: Size.Short) -> Node[..] { [Node {}; 2] }
fn replacement(size: Size.Full) -> Node[..] { [Node {}; 3] }

fn linked(size: Size) -> Node[..] {
    var nodes: Node[..] = [Node {}; 3];
    let saved .= nodes[2];
    nodes = replacement(size);
    nodes[0].next .= saved;
    return nodes;
}

fn main() { let live: Node[] = linked(Size.Short); print(live.len); }
