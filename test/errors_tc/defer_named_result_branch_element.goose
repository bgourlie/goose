// error: defer body writes through an alias to out
fn numbers(flag: bool) -> i64[] {
    defer { abort("stop"); }
    return if flag { [] } else { [7] };
}
fn build(flag: bool) -> i64[>..] {
    var out: i64[>..] = [41];
    let alias .= out;
    defer { alias.append(numbers(flag)); }
    return out;
}
fn main() { print(build(false)); }
