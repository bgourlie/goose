// error: a defer on this exit can observe buf partially rebuilt
struct Buffer { header: i64[1], xs: i64[>..<] }

fn replace(stop: bool) {
    var buf = Buffer { header: [1], xs: [1] };
    var spare: i64[1] = [7];
    var view = buf.header[..];
    defer { view = spare[..view[0]]; }
    buf = Buffer { header: [0], xs: [2, if stop { return; } else { 3 }] };
}

fn main() { replace(true); }
