// error: retained storage may have a self-relative link to a removed element
struct Node { value: i64 }
struct Header { first: Node&<u32>? }
struct List { headers: Header[2], nodes: Node[>..] }

fn reset(header: Header&) { header.first .= null; }

fn main() {
    var xs = List { headers: [Header {}, Header {}], nodes: [Node { value: 1 }] };
    xs.headers[1].first .= xs.nodes[0];
    reset(xs.headers[0]);
    xs.nodes.clear();
}
