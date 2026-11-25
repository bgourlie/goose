// error: defer body writes through an alias to out, which build returns by name
fn increment(xs: i64[]&) { xs[0]++; }
fn build() -> i64[] {
    var out: i64[] = [1];
    var spare: i64[] = [2];
    var alias .= spare;
    defer increment(alias);
    alias .= out;
    return out;
}
fn main() { print(build()); }
