// error: defer body writes through an alias to out
fn build() -> i64[] {
    var out: i64[] = [42];
    var spare = 0;
    var target .= spare;
    let first .= out[0];
    fn phase() {
        fn leave() { target .= spare; return from phase; }
        fn relay() {
            defer { target .= first; }
            leave();
        }
        relay();
    }
    phase();
    defer { target++; }
    return out;
}
fn main() { print(build()); }
