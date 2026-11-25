// error: retained storage may have a self-relative link to a removed element
struct Node { value: i64 }
struct List { first: Node&<u32>?, nodes: Node[>..] }
root struct State { left: List, right: List }

fn link(st: State&) { st.left.first .= st.left.nodes[0]; }
fn unlink(st: State&) { st.right.first .= null; }

fn main() {
    var st = State { left: List { nodes: [Node { value: 1 }] }, right: List { nodes: [] } };
    link(st);
    unlink(st);
    st.left.nodes.clear();
}
