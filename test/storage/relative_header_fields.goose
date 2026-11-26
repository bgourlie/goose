struct Node { value: i64 }
struct Header { first: Node&<u32>?, second: Node&<u32>?, untouched: Node&<u32>? }
struct List { header: Header, spare: Header = Header {}, nodes: Node[>..] }

fn link(header: Header&, node: Node&, first: bool) {
    if first { header.first .= node; } else { header.second .= node; }
}

fn reset(header: Header&) { header.first .= null; }
fn linked(node: Node&) -> Header { Header { first: node } }
fn forward(node: Node&) -> Header { linked(node) }

var shared = List { header: Header {}, nodes: [] };
export fn add_shared() {
    shared.nodes.push(Node { value: 5 });
    shared.header.first .= shared.nodes[0];
}
export fn clear_shared() {
    shared.header.first .= null;
    shared.nodes.clear();
}

fn main() {
    var list = List { header: Header {}, nodes: [Node { value: 1 }] };
    list.header.first .= list.nodes[0];
    list.header.first .= null;
    list.nodes.clear();
    list.nodes.push(Node { value: 3 });
    list.header = Header { second: list.nodes[0] };
    list.header.second .= null;
    list.nodes.clear();
    list.nodes.push(Node { value: 4 });
    list.header = forward(list.nodes[0]);
    assert(list.header.first .== list.nodes[0]);
    reset(list.header);
    list.nodes.clear();
    list.nodes.push(Node { value: 5 });
    list.header.first .= list.nodes[0];
    {
        var header .= list.spare;
        fn select_header() { header .= list.header; }
        select_header();
        header.first .= block { header.first .= list.nodes[0]; null };
    }
    list.nodes.clear();
    for first in [true, false] {
        list.nodes.push(Node { value: 2 });
        link(list.header, list.nodes[0], first);
        if first { assert(list.header.first .== list.nodes[0]); }
        else { assert(list.header.second .== list.nodes[0]); }
        reset(list.header);
        list.header.second .= null;
        list.nodes.clear();
    }
    assert(list.nodes.len == 0);
    add_shared();
    clear_shared();
    assert(shared.nodes.len == 0);
    print("ok");
}
