// error: retained storage may have a self-relative link to a removed element
struct Cell { next: Cell&<u32>?, value: i64&<u32>? }
struct Chain { first: Cell[..2], second: Cell[..2], values: i64[>..] }

fn empty_cells(cells: Cell[..2]&) { cells.clear(); }
fn main() {
    var x = Chain { first: [Cell {}], second: [Cell {}], values: [42] };
    x.first[0].next .= x.second[0];
    x.second[0].value .= x.values[0];
    let view .= x.first[0];
    x.second.clear();
    empty_cells(x.first);
    x.values.clear();
    let next .= view.next;
    if next { assert(next.value != null); }
}
