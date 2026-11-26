struct Node { next: Node&<u32>?, owner: Node[]&<u32>? }
struct List { first: Node&<u32>?, nodes: Node[>..] }

fn linked() -> Node[] {
    var nodes: Node[] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    return nodes;
}

fn growable() -> Node[>..] { linked() }

fn limited_pair() -> Node[..] {
    var nodes: Node[..] = [Node {}, Node {}];
    nodes[0].next .= nodes[1];
    return nodes;
}

fn forward_pair() -> Node[..] { limited_pair() }

fn grown_pair() -> Node[..] {
    var nodes: Node[..] = [..4];
    nodes.push(Node {});
    nodes.push(Node {});
    nodes[0].next .= nodes[1];
    return nodes;
}

fn header_link() -> Node[] {
    var nodes: Node[] = [Node {}];
    nodes[0].owner .= nodes;
    return nodes;
}

fn make_list() -> List { List { nodes: growable() } }

struct Entry { field: i64[1], inner: i64[1]&<u32>?, owner: Entry[]&<u32>? }

fn entries() -> Entry[] {
    var xs: Entry[] = [Entry { field: [42] }];
    xs[0].inner .= xs[0].field;
    return xs;
}

fn main() {
    let pair: Node[] = forward_pair();
    assert(pair.len == 2 && pair[0].next .== pair[1]);
    let run: Node[] = grown_pair();
    assert(run.len == 2 && run[0].next .== run[1]);
    let unchanged: Node[] = header_link();
    assert(unchanged[0].owner .== unchanged);
    var list = make_list();
    assert(list.first == null && list.nodes[0].next .== list.nodes[1]);
    list.nodes.clear();
    assert(list.nodes.len == 0);
    var grown: Entry[>..] = entries();
    assert(grown[0].inner .== grown[0].field && grown[0].owner == null);
    print("ok");
}
