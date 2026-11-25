// error: defer body writes through an alias to out
fn maybe_stop(flag: bool) -> i64 {
    if flag { abort("stop"); }
    return 42;
}
fn build(flag: bool) -> i64[] {
    var out: i64[] = [41];
    let alias .= out[0];
    defer { alias = maybe_stop(flag); }
    return out;
}
fn main() { print(build(false)); }
