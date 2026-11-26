// error: expected a value of type i64, got bool
struct Stop {}
fn format(out: u8[>..]&, s: Stop) { abort("unreached"); }
fn format(out: u8[>..]&, s: Stop, n: i64) { print(n); }
fn choose(flag: bool) -> i64 {
    var out: u8[>..] = [];
    fn value() -> i64 { if flag { return true from choose; } return 3; }
    format(out, Stop {}, value() + 1);
    return 42;
}
fn main() { print(choose(true)); }
