// error: a defer on this exit can observe state.items partially rebuilt
root struct State { items: i64[>..<], spare: i64[>..<] }
fn make(stop: bool) {
    var state = State { items: [1], spare: [] };
    defer { print(state.items.len); }
    state.items = [2, if stop { return; } else { 3 }];
}
fn main() { make(false); }
