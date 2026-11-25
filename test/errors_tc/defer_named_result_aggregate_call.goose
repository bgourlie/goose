// error: defer body writes through an alias to out
struct Small { value: i64 }
fn number(fail: bool) -> i64 {
    if fail { abort("stop"); }
    return 42;
}
fn make(n: i64) -> Small { Small { value: n } }
fn build(fail: bool) -> Small[] {
    var out: Small[] = [Small { value: 41 }];
    let first .= out[0];
    defer { first = make(number(fail)); }
    return out;
}
fn main() { print(build(false)); }
