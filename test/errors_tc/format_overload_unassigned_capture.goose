// error: variable later may be used before it is assigned
struct Stop {}
fn format(out: u8[>..]&, value: Stop) { return 7 from choose; }
fn format(out: u8[>..]&, value: Stop, n: i64) { out.push(n as u8); }
fn choose() -> i64 {
    var out: u8[>..] = [];
    var later: i64;
    fn read_later() -> i64 { later }
    fn inferred_later() { read_later() }
    format(out, Stop {}, inferred_later() + 1);
    return 42;
}
fn main() { print(choose()); }
