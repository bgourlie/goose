// error: defer body writes through an alias to out, which build returns by name
fn grow(xs: i64[>..]&) { xs.push(42); }
fn forward(xs: i64[>..]&) { grow(xs); }
fn build() -> i64[>..] {
    var out: i64[>..] = [];
    let alias .= out;
    forward(alias);
    defer forward(alias);
    return out;
}
fn main() { print(build()); }
