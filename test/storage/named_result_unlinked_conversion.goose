// xfail: codegen internal error: nodes holds self-relative references and is not built where it is returned
// The optional link is null, so converting the returned array leaves no interior link (§§4.3, 5.2).
struct Node { n: i64, next: Node&<u32>? }

fn unlinked() -> Node[] {
    let nodes: Node[] = [Node { n: 42 }];
    return nodes;
}

fn main() {
    var nodes: Node[>..<] = unlinked();
    assert(nodes[0].n == 42);
}
