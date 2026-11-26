// error: defer body writes through an alias to out
fn transfer(source: i64[:], target: i64[:]) { target.move_from(source); }
fn build() -> i64[] {
    var out: i64[] = [42];
    var spare: i64[] = [0];
    var source: i64[:] = out[..];
    source = spare[..];
    var target: i64[:] = out[..];
    target = spare[..];
    target = out[..];
    defer transfer(source, target);
    return out;
}
fn main() { print(build()); }
