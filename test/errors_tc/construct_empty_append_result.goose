// error: the run appended to pool is still under construction
struct Item { key: i64, next: Item&<u32 in pool>? }
var pool: Item[>..] = [];

fn empty() -> Item[..] { return [..3]; }
fn second() -> i64 { pool.append(empty()); return 8; }

fn main() {
    pool.append([Item { key: 7 }, Item { key: second() }]);
}
