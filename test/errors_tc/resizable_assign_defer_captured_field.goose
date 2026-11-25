// error: a defer on this exit can observe bag.xs partially rebuilt
struct Bag { tag: i64, xs: i64[>..<] }
fn make(stop: bool) {
    var bag = Bag { tag: 7, xs: [1] };
    fn audit() {
        assert(bag.tag == 7);
        print(bag.xs.len);
    }
    fn relay() { audit(); }
    defer relay();
    bag.xs = [2, if stop { return; } else { 3 }];
}
fn main() { make(false); }
