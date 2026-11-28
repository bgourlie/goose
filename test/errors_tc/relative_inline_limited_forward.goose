// error: retained storage may have a self-relative link to a removed element
struct Row { selected: i64&<u32>?, values: i64[..3] }
fn main() {
    var rows: Row[>..] = [Row { values: [3, 7] }; 2];
    rows[0].selected .= rows[1].values[0];
    rows.pop();
}
