// xfail: codegen internal error: nodes holds self-relative references and is not built where it is returned
// Only the path that aborts installs a link. The caller receives the unlinked array (§§6.6, 7.3).
struct Node { next: Node&<u32>? }

fn explicit_result(stop: bool) -> Node[] {
    var nodes: Node[] = [Node {}, Node {}];
    if stop {
        nodes[0].next .= nodes[1];
        defer { abort("stop"); }
        return nodes;
    }
    return nodes;
}

fn main() {
    var nodes: Node[>..<] = explicit_result(false);
    assert(nodes.len == 2);
}
