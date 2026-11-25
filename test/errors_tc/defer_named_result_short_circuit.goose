// error: defer body writes through an alias to out
fn build(change: bool) -> i64[] {
    var out: i64[] = [42];
    var spare = 0;
    var target .= spare;
    let first .= out[0];
    fn move() -> bool { target .= first; return true; }
    let changed = change && move();
    defer { target++; }
    return out;
}
fn main() { print(build(true)); }
