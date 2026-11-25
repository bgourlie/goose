// error: evaluate the computation that can exit before assigning to xs
fn replace(xs: i64[>..<]&, stop: bool) {
    xs = [1, if stop { return; } else { 2 }];
}
fn main() {
    var xs: i64[>..<] = [10];
    replace(xs, false);
}
