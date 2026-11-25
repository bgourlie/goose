// error: defer body writes through an alias to out
fn build(early: bool) -> i64[] {
    var out: i64[] = [1];
    var spare = 2;
    var written .= out[0];
    defer { written++; }
    if early { return out; }
    written .= spare;
    return out;
}
fn main() { print(build(false)); }
