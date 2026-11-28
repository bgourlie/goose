// error: the run appended to pool is still under construction
struct Item { key: i64, next: Item&<u32 in pool>? }
var pool: Item[>..] = [];

fn stop() -> i64 { return 8 from second; }
fn second() -> i64 {
    pool.append([Item { key: 3 }, Item { key: stop() }]);
    return 9;
}

fn main() {
    pool.append([Item { key: 7 }, Item { key: second() }]);
}
