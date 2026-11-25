// error: defer body writes through an alias to out
fn stop() -> i64 { abort("stop"); }
fn build(flag: bool) -> u8[>..] {
    var out: u8[>..] = [];
    let alias .= out;
    defer { if flag { alias.append(str("prefix", stop())); } }
    return out;
}
fn main() { print(build(false)); }
