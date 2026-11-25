// error: defer body writes through an alias to out
fn build() -> i64[] {
    var out: i64[>..] = [41, 42];
    let first .= out[0];
    defer { first++; }
    return out;
}
fn main() { print(build()); }
