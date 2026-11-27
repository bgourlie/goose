// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }

fn trim(choices: bool[:]) {
    var a:        Node[>..]   = [Node {}, Node {}];
    var b:        Node[>..]   = [Node {}];
    var previous: Node[>..]&? = null;
    for first in choices {
        let selected: Node[>..]& = if first { a } else { b };
        if previous == null {
            a[0].next .= a[1];
            previous .= selected;
            continue;
        }
        selected.resize(previous.len);
    }
}

fn main() { trim([false, true]); }
