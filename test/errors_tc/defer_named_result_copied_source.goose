// error: defer body names source, which build returns by name
fn build() -> i64[] {
    var source: i64[2] = [41, 42];
    defer { print(source[0]); }
    return source;
}
fn main() { print(build()); }
