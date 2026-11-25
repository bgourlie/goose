// error: a defer on this exit can observe xs partially rebuilt
struct Box { target: i64[>..<]& }
fn observe(box: Box&) { print(box.target.len); }
fn make(stop: bool) {
    var xs: i64[>..<] = [1];
    let box = Box { target: xs };
    defer observe(box);
    xs = [2, if stop { return; } else { 3 }];
}
fn main() { make(false); }
