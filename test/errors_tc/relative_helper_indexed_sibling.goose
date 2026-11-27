// error: retained storage may have a self-relative link to a removed element
struct Links { next: Node&<u32>? }
struct Node { slots: Links[2] = [Links {}, Links {}] }

fn connect(slot: Links&, target: Node&) { slot.next .= target; }
fn connect_slot(n: Node&, target: Node&, j: i64) { connect(n.slots[j], target); }

fn trim(index: i64) {
    var nodes: Node[>..] = [Node {}, Node {}, Node {}];
    connect_slot(nodes[index], nodes[2], 1);
    nodes[index].slots[0].next .= null;
    nodes.pop_n(1);
}

fn main() { trim(1); }
