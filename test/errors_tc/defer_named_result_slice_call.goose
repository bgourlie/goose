// error: defer body writes through an alias to out
fn increment_first(view: i64[:]) { view[0]++; }
fn build(change: bool) -> i64[] {
    var out: i64[] = [42];
    var spare: i64[] = [0];
    var view: i64[:] = out[..];
    if change { view = spare[..]; }
    defer increment_first(view);
    return out;
}
fn main() { print(build(false)); }
