struct Stage { value: i64 }
var order: i64 = 0;

fn format(out: u8[>..]&, stage: Stage) {
    defer { order = order * 10 + 1; }
    return stage.value from render;
}

fn write_stage() {
    defer { order = order * 10 + 2; }
    print(Stage { value: 7 });
    order = 99;
}

fn render(direct: bool) -> i64 {
    defer { order = order * 10 + 3; }
    if direct { print(Stage { value: 5 }); }
    write_stage();
    return 11;
}

struct Base { value: i64 }
fn format(out: u8[>..]&, base: Base) { return base.value from sum; }
recursive fn sum(n: i64) -> i64 {
    if n == 0 {
        print(Base { value: 4 });
        return 0;
    }
    return n + sum(n - 1);
}

struct Stop {}
struct MaybeStop { stop: bool }
fn format(out: u8[>..]&, s: Stop) { return 7 from choose; }
fn format(out: u8[>..]&, s: MaybeStop) {
    if s.stop { return 7 from choose; }
    out.append("x");
}
// An overload of the shortened call. Rechecking the named builtin must
// still resolve it using all four original arguments.
fn format(out: u8[>..]&, n: i64, s: Stop) { abort("wrong overload"); }
fn number(n: i64) -> i64 { n }
fn stop_index() -> i64 { print(Stop {}); return 0; }

fn choose(mode: i64, flag: bool) -> i64 {
    var out: u8[>..] = [];
    if mode == 0 { print(Stop {}, if flag { 1 } else { 2 }); }
    if mode == 1 {
        let text = Stop {}.str(if flag { 1 } else { 2 });
        return text.len;
    }
    if mode == 2 { out.format(Stop {}, if flag { 1 } else { 2 }); }
    if mode == 3 {
        return number(block {
            if flag { break 8; }
            format(out, 1, Stop {}, if flag { 1 } else { 2 });
            42
        });
    }
    if mode == 4 {
        var buffers: u8[..8][1] = [""];
        buffers[stop_index()].format(if flag { 1 } else { 2 });
    }
    let text = str(MaybeStop { stop: flag }, if flag { 1 } else { 2 });
    assert(text == "x2");
    return 42;
}

fn main() {
    assert(render(true) == 5 && order == 13);
    order = 0;
    assert(render(false) == 7 && order == 123);
    assert(sum(3) == 10);
    for mode in 5 { assert(choose(mode, false) == 7); }
    assert(choose(3, true) == 8);
    assert(choose(5, true) == 7 && choose(5, false) == 42);
    print("ok");
}
