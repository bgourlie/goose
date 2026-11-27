// error: defer body writes through an alias to out
fn inner(escape: bool) -> i64[>..] {
    var out: i64[>..] = [1];
    if escape {
        let alias .= out;
        defer { alias.push(99); }
        return [7] from outer;
    }
    return out;
}

fn outer(escape: bool) -> i64[>..] { return inner(escape); }
fn main() { var values = outer(true); print(values); }
