fn number(stop: bool) -> i64 {
    if stop { return from replace; }
    return 3;
}

fn replace(xs: i64[>..<]&, stop: bool) {
    let n = number(stop);
    xs = [2, n];
}

fn finish() -> i64 { return 4 from operand; }
fn operand() -> i64 { finish() }

fn discard(early: bool, observed: i64&) {
    var xs: i64[>..<] = [0];
    defer { observed++; }
    xs = [1, if early { return; } else { 2 }];
    assert(xs.len == 2);
}

fn leave() -> i64 { return from outer; }
fn install(xs: i64[>..<]&) { xs = [1, leave()]; }
fn relay(xs: i64[>..<]&) { install(xs); }
fn outer() {
    var xs: i64[>..<] = [0];
    relay(xs);
}

struct Bag { tag: i64, xs: i64[>..<] }
struct Box { tag: i64, items: i64[>..<]& }
struct Views { flag: bool&, data: i64[>..<]& }
fn siblings(stop: bool) {
    var bag = Bag { tag: 7, xs: [1] };
    let alias .= bag;
    let tag .= bag.tag;
    let box = Box { tag: 8, items: bag.xs };
    let flag = true;
    let views = Views { flag: flag, data: bag.xs };
    let saved = views;
    defer { assert(views.flag && saved.flag); }
    fn audit() { assert(bag.tag == 7); }
    fn relay_audit() { audit(); }
    defer relay_audit();
    defer { assert(tag == 7 && alias.tag == 7 && box.tag == 8); }
    bag.xs = [2, if stop { return; } else { 3 }];
}

struct Pair { first: i64[>..<]&, second: i64[>..<]& }

fn bind_first(p: Pair&, xs: i64[>..<]&) { p.first .= xs; }

fn same_typed_fields(stop: bool) {
    var xs: i64[>..<] = [1];
    var ys: i64[>..<] = [2];
    var p = Pair { first: xs, second: ys };
    bind_first(p, xs);
    let saved = p;
    fn observe() { assert(saved.second.len == 1); }
    defer observe();
    defer { assert(p.second.len == 1); }
    xs = [3, if stop { return; } else { 4 }];
}

fn named_result(stop: bool) -> i64[>..<] {
    var xs: i64[>..<] = [1, 2];
    xs = [5, if stop { return [7, 8]; } else { 6 }];
    return xs;
}

root struct State { items: i64[>..<], spare: i64[>..<] }
fn components(stop: bool) {
    var state = State { items: [1], spare: [9] };
    let alias .= state;
    defer { assert(alias.spare.len == 1); }
    fn audit() { assert(state.spare[0] == 9); }
    defer audit();
    state.items = [2, if stop { return; } else { 3 }];
}

fn main() {
    var xs: i64[>..<] = [9];
    replace(xs, true);
    assert(xs.len == 1 && xs[0] == 9);
    replace(xs, false);
    assert(xs.len == 2 && xs[1] == 3);
    xs = [block { break operand(); }, loop { break 5; }];
    assert(xs.len == 2 && xs[0] == 4 && xs[1] == 5);
    var observed = 0;
    discard(true, observed);
    discard(false, observed);
    assert(observed == 2);
    outer();
    siblings(true);
    siblings(false);
    let other = named_result(true);
    assert(other.len == 2 && other[0] == 7 && other[1] == 8);
    components(true);
    same_typed_fields(true);
    same_typed_fields(false);
    print("ok");
}
