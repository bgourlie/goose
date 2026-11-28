// error: cannot pop_n reusable pool pool
reusable var pool: i64[>..] = [];
fn main() {
    for i in 0 { pool.pop_n(1); }
}
