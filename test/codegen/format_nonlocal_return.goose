// xfail: typecheck variable later_global may be used before it is assigned
// Formatting Stop exits early() before the formatter reaches the later global (§§3.7, 7.9, 11.1).
struct Stop {}
fn format(out: u8[>..]&, s: Stop) { return 7 from early; }
fn early() -> i64 {
    var out: u8[>..] = [];
    format(out, Stop {}, later_global);
    return 42;
}
let result = early();
let later_global: i64 = 8;
fn main() { assert(result == 7); }
