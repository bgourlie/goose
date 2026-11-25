// error: this exit can leave xs partially rebuilt
fn main() {
    var xs: i64[>..] = [];
    for i in 0..3 { xs = [1, if i == 1 { continue; } else { i }]; }
}
