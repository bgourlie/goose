// xfail: accepts-invalid
// error: optional value must be narrowed
// The loop reloads seq after the body has rebound it to null (§6.5).
fn main() {
    var rows = [1, 2];
    var seq: i64[2]&? = rows;
    if seq {
        for n in seq {
            print(n);
            seq .= null;
        }
    }
}
