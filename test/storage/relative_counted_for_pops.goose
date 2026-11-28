struct Node { next: Node&<u32>? }
var nodes: Node[>..] = [Node {}; 2];

fn trim_pair(skip: bool) {
    for i in 2 {
        defer { nodes.pop(); }
        if skip { continue; }
    }
}
fn trim_until(stop: bool) {
    for i in -1..1 {
        nodes.pop();
        if stop { break; }
    }
}
fn main() {
    nodes[0].next .= nodes[1];
    nodes.append([Node {}; 2]);
    for i in 2 { nodes.pop(); }
    assert(nodes.len == 2 && nodes[0].next .== nodes[1]);
    nodes.append([Node {}; 2]);
    trim_pair(true);
    nodes.append([Node {}; 2]);
    trim_until(false);
    assert(nodes.len == 2);

    const COUNT: u8 = 2;
    nodes.append([Node {}; 2]);
    for i in COUNT { nodes.pop(); }
    assert(nodes.len == 2 && nodes[0].next .== nodes[1]);

    let fixed = [4, 5];
    let limited: i64[..2] = [1];
    nodes.append([Node {}; 4]);
    for x in fixed { nodes.pop(); }
    for x in limited { nodes.pop(); }
    assert(nodes.len == 3 && nodes[0].next .== nodes[1]);
    print("ok");
}
