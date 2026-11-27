// error: a defer on this exit can observe xs partially rebuilt
struct Box { tag: i64, data: i64[>..<]& }
fn replace(stop: bool) {
    var xs: i64[>..<] = [1];
    let boxes = [Box { tag: 7, data: xs }];
    defer { print(boxes[0].data.len); }
    xs = [3, if stop { return; } else { 4 }];
}
fn main() { replace(true); }
