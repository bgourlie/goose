// error: retained storage may have a self-relative link to a removed element
struct Cells { head: i64&<u32>?, data: i64[>..] }

fn empty_after_push(cells: Cells&) -> i64[0] {
    cells.data.push(3);
    return [];
}

fn main() {
    var cells = Cells { data: [1, 2] };
    const size = cells.data.len;
    cells.data.append(empty_after_push(cells));
    cells.head .= cells.data[2];
    cells.data.resize(size);
}
