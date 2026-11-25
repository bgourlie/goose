// error: retained storage may have a self-relative link to a removed element
struct Node { value: i64 }
struct List { first: Node&<u32>?, second: Node&<u32>?, nodes: Node[>..] }
root struct State { list: List, other: i64 }

fn main() {
    var st = State { list: List { nodes: [Node { value: 1 }] }, other: 0 };
    st.list.first .= st.list.nodes[0];
    st.list.second .= null;
    st.list.nodes.clear();
}
