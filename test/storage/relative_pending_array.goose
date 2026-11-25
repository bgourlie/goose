struct Node { next: Node&<u32>? }

fn mark(nodes: Node[>..]&) -> i64 {
    nodes.pop_n(1);
    nodes.push(Node {});
    nodes[0].next .= nodes[1];
    42
}

fn main() {
    var nodes: Node[>..] = [Node {}, Node {}];
    var pushed = [];
    pushed.push(mark(nodes));
    assert(nodes[0].next .== nodes[1] && pushed[0] == 42);

    var other: Node[>..] = [Node {}, Node {}];
    var appended = [];
    appended.append([mark(other)]);
    assert(other[0].next .== other[1] && appended[0] == 42);

    var third: Node[>..] = [Node {}, Node {}];
    var assigned = [];
    assigned = [mark(third)];
    assert(third[0].next .== third[1] && assigned[0] == 42);
    print("ok");
}
