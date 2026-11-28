// xfail: codegen internal error: xs holds self-relative references and is not built where it is returned
// Converting the returned array to grow-only storage preserves the link to its field (§4.3).
struct Entry { field: i64[1], inner: i64[1]&<u32>?, owner: Entry[]&<u32>? }

fn entries() -> Entry[] {
    var xs: Entry[] = [Entry { field: [42] }];
    xs[0].inner .= xs[0].field;
    return xs;
}

fn main() {
    var grown: Entry[>..] = entries();
    assert(grown[0].inner .== grown[0].field && grown[0].owner == null);
}
