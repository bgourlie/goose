// error: a defer on this exit can observe xs partially rebuilt
fn observe(xs: i64[>..<]&) { print(xs.len); }
fn make(stop: bool) {
    var xs: i64[>..<] = [1];
    let alias .= xs;
    defer observe(alias);
    xs = [2, if stop { return; } else { 3 }];
}
fn main() { make(false); }
