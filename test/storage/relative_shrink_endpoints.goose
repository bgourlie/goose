struct Node { next: Node&<u32>? }

fn trim(nodes: Node[>..]&) { nodes.pop_n(2); }
fn add_one(nodes: Node[>..]&) { nodes.push(Node {}); }
fn connect(nodes: Node[>..]&) { nodes[2].next .= nodes[3]; }

fn main() {
    var nodes: Node[>..] = [Node {}; 4];
    nodes[2].next .= nodes[3];
    nodes.resize(2);
    assert(nodes.len == 2 && nodes[1].next == null);

    add_one(nodes);
    add_one(nodes);
    connect(nodes);
    trim(nodes);
    assert(nodes.len == 2 && nodes[1].next == null);

    nodes.append([Node {}; 2]);
    { let src .= nodes[2]; src.next .= nodes[3]; }
    { defer nodes.pop_n(2); }
    assert(nodes.len == 2);

    nodes.append([Node {}; 2]);
    nodes[2].next .= nodes[3];
    nodes.pop_n(2);
    nodes.append([Node {}; 2]);
    nodes.pop();
    assert(nodes.len == 3 && nodes[2].next == null);
    print("ok");
}
