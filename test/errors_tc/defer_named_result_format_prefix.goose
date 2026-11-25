// error: defer body writes through an alias to out
struct Stop {}
struct Message { field: Stop }
fn format(out: u8[>..]&, value: Stop) { abort("stop"); }
fn build(flag: bool) -> u8[>..] {
    var out: u8[>..] = [];
    let alias .= out;
    defer { if flag { alias.format(Message { field: Stop {} }); } }
    return out;
}
fn main() { print(build(false)); }
