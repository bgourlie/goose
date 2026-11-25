// error: this exit can leave xs partially rebuilt
fn run(stop: bool) {
    var xs: i64[>..] = [1];
    loop { xs = [2, if stop { break; } else { 3 }]; }
}
fn main() { run(true); }
