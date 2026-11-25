struct Node { refs: (Node&<u32>)[..2] }
struct List { head: Node, first: Node&<u32>?, links: (Node&<u32>?)[2], nodes: Node[>..] }
struct Group { headers: Node[2], nodes: Node[>..] }
root struct State { list: List, other: i64 }

fn add(node: Node&, target: Node&) { node.refs.push(target); }
fn link(st: State&) { st.list.first .= st.list.nodes[0]; }
fn unlink(st: State&) { st.list.first .= null; }

fn nested_arrays() {
    var xs = List { head: Node { refs: [] }, links: [null, null], nodes: [Node { refs: [] }] };
    xs.nodes[0].refs.push(xs.head);
    assert(xs.nodes[0].refs[0] .== xs.head);
    xs.nodes.clear();
    xs.nodes.push(Node { refs: [] });
    add(xs.head, xs.nodes[0]);
    xs.head.refs = [];
    add(xs.nodes[0], xs.head);
    xs.nodes.clear();
}

fn indexed_field(i: i64) {
    var xs = List { head: Node { refs: [] }, links: [null, null], nodes: [Node { refs: [] }] };
    xs.links[i] .= xs.nodes[0];
    assert(xs.links[i] .== xs.nodes[0]);
    xs.links = [null, null];
    xs.nodes.clear();

    var group = Group { headers: [Node { refs: [] }, Node { refs: [] }], nodes: [Node { refs: [] }] };
    {
        let header .= group.headers[i];
        add(header, group.nodes[0]);
    }
    group.headers = [Node { refs: [] }, Node { refs: [] }];
    group.nodes.clear();
}

fn root_component() {
    var st = State { list: List {
        head: Node { refs: [] }, links: [null, null], nodes: [Node { refs: [] }]
    }, other: 0 };
    st.list.first .= st.list.nodes[0];
    st.list.first .= null;
    st.list.nodes.clear();
    st.list.nodes.push(Node { refs: [] });
    link(st);
    assert(st.list.first .== st.list.nodes[0]);
    unlink(st);
    st.list.nodes.clear();
}

fn main() {
    nested_arrays();
    indexed_field(1);
    root_component();
    print("ok");
}
