// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn trim(indices: i64[:]) {
    var nodes: Node[>..] = [Node {}, Node {}, Node {}];
    for index, i in indices {
        let slot .= nodes[index];
        if i == 0 {
            slot.next .= nodes[2];
            continue;
        }
        slot.next .= null;
        nodes.pop_n(1);
        break;
    }
}

fn main() {
    let indices = [0, 1];
    trim(indices);
}
