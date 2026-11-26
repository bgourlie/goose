// error: variable later may be used before it is assigned: globals initialize in declaration order
struct Stop {}
fn format(out: u8[>..]&, s: Stop) { abort("unreached"); }
fn format(out: u8[>..]&, s: Stop, n: i64) { print(n); }
fn choose() -> i64 {
    var out: u8[>..] = [];
    fn read() { later }
    format(out, Stop {}, read() + 1);
    return 42;
}
let first = choose();
let later: i64 = 7;
fn main() { print(first); }
