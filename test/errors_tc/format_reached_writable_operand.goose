// error: relies on it keeping its initializer's value
struct Stop {}
let count = 2;
fn format(out: u8[>..]&, s: Stop) { return 7 from render; }
fn format(out: u8[>..]&, s: Stop, n: i64) { out.push(0); }
fn touch(n: i64&) -> i64 { n = 9; return n; }

fn render() -> i64 {
    var out: u8[>..] = [];
    let fixed: i64[count] = [11, 12];
    format(out, Stop {}, touch(&count));
    return fixed.len;
}
fn main() { print(render()); }
