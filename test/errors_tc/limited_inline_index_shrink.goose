// error: a self-relative link may name a slot beyond the live length
struct Cell { values: i64[2] = [4, 5], target: i64&<u32>? }

fn cells() -> Cell[..] {
    var cells: Cell[..] = [Cell {}; 2];
    fn index() -> i64 { cells.pop_n(1); return 0; }
    cells[0].target .= cells[1].values[index()];
    return cells;
}

fn main() { let live: Cell[] = cells(); print(live.len); }
