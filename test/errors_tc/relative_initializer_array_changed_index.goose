// error: retained storage may have a self-relative link to a removed element
struct Cell { value: i64 = 0, link: i64&<u32>? }
struct Row { cells: Cell[2] = [Cell {}; 2] }
fn main() {
    var rows: Row[>..] = [Row {}; 2];
    var i = 0;
    fn advance() -> i64 { i = 1; return 0; }
    rows[i] = Row { cells: [Cell { value: advance() }, Cell { link: rows[i].cells[0].value }] };
    rows.pop();
}
