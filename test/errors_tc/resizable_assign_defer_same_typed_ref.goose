// error: a defer on this exit can observe xs partially rebuilt
struct Pair { first: i64[>..<]&, second: i64[>..<]& }
fn bind_second(p: Pair&, xs: i64[>..<]&) { p.second .= xs; }
fn replace(stop: bool) {
    var xs: i64[>..<] = [1];
    var ys: i64[>..<] = [2];
    var p = Pair { first: xs, second: ys };
    bind_second(p, xs);
    let saved = p;
    defer { assert(saved.second.len == 1); }
    xs = [3, if stop { return; } else { 4 }];
}
fn main() { replace(true); }
