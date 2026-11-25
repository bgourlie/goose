// error: a defer on this exit can observe list partially rebuilt
struct List { n: i64, xs: i64[>..<] }
fn make(stop: bool) {
    var list = List { n: 0, xs: [1] };
    let n .= list.n;
    defer { print(n); }
    list = List { n: 1, xs: [if stop { return; } else { 2 }] };
}
fn main() { make(false); }
