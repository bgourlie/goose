// error: a defer on this exit can observe bag partially rebuilt
struct Bag { flag: bool, xs: i64[>..<] }
struct Views { flag: bool&, data: i64[>..<]& }
fn make(stop: bool) {
    var spare: i64[>..<] = [];
    var bag = Bag { flag: true, xs: [1] };
    let views = Views { flag: bag.flag, data: spare };
    defer { assert(views.flag); }
    bag = Bag { flag: false, xs: [2, if stop { return; } else { 3 }] };
}
fn main() { make(false); }
