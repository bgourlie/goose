// error: defer body writes through an alias to out
fn stop() -> i64 { abort("stop"); }
fn numbers(n: i64) -> i64[] {
    var result: i64[] = [n, stop()];
    return result;
}
fn build(n: i64) -> i64[>..] {
    var out: i64[>..] = [41];
    let alias .= out;
    defer { alias.append(numbers(n)); }
    return out;
}
fn main() { print(build(0)); }
