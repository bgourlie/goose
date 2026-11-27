// error: defer body writes through an alias to out
fn build(early: bool) -> i64[] {
    var out: i64[] = [1];
    let first .= out[0];
    {
        defer { first++; }
        if early { return out; }
    }
    return out;
}

fn main() { print(build(true)); }
