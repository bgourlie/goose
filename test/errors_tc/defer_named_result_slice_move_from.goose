// error: defer body writes through an alias to out
fn build() -> i64[] {
    var out: i64[] = [42];
    var spare: i64[] = [0];
    var view: i64[:] = spare[..];
    view = out[..];
    defer { view.move_from(spare[..]); }
    return out;
}
fn main() { print(build()); }
