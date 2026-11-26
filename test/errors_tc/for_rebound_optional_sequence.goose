// error: optional value must be narrowed
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
