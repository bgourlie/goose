// error: a defer on this exit can observe x.data partially rebuilt
struct Data { tag: i64, xs: i64[>..<] }
struct Outer { alias: Data&, data: Data }
fn replace(stop: bool) {
    var other = Data { tag: 5, xs: [] };
    var x = Outer { alias: other, data: Data { tag: 7, xs: [1] } };
    x.alias .= x.data;
    defer { print(x.alias.tag); }
    x.data = Data { tag: 9, xs: [2, if stop { return; } else { 3 }] };
}
fn main() { replace(true); }
