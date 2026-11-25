// error: this exit can leave xs partially rebuilt
fn leave() -> i64 { return from outer; }
fn install(xs: i64[>..<]&) { xs = [1, leave()]; }
fn relay(xs: i64[>..<]&) { install(xs); }
fn outer(xs: i64[>..<]&, local: bool) {
    var scratch: i64[>..<] = [0];
    if local { relay(scratch); } else { relay(xs); }
}
fn main() {
    var xs: i64[>..<] = [0];
    outer(xs, false);
}
