// error: defer body writes through an alias to out
fn numbers() -> i64[] { [7] }
fn stopped() -> i64[] { defer { abort("stop"); } return numbers(); }
fn build(flag: bool) -> i64[>..] {
    var out: i64[>..] = [41];
    let alias .= out;
    defer { if flag { alias.append(stopped()); } }
    return out;
}
fn main() { print(build(false)); }
