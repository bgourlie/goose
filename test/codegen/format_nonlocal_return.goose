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
fn format(out: u8[>..]&, s: Stop, other: MaybeStop) { abort("wrong overload"); }
fn number(n: i64) -> i64 { n }
fn stop_index() -> i64 { print(Stop {}); return 0; }

fn choose(mode: i64, flag: bool) -> i64 {
    var out: u8[>..] = [];
    var later: i64;
    fn read_later() -> i64 { later }
    fn inferred_later() { read_later() }
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
    // The third argument's type rules out the overload. The builtin exits
    // while rendering Stop, so it never needs the argument's value.
    if mode == 6 {
        if flag { out.format(Stop {}, later); } else { format(out, Stop {}, later); }
    }
    // No overload takes four arguments. The last call is never reached.
    if mode == 7 { format(out, 1, Stop {}, read_later()); }
    if mode == 8 { format(out, Stop {}, read_later()); }
    if mode == 9 { format(out, Stop {}, inferred_later() + 1); }
    let text = str(MaybeStop { stop: flag }, if flag { 1 } else { 2 });
    assert(text == "x2");
    return 42;
}

fn check_format_overload() {
    fn format<F>(n: i64 = 40) -> i64 { F(n) }
    fn add_two(n: i64) -> i64 { n + 2 }
    assert(format(add_two) == 42);
    assert(format(40, add_two) == 42);
    assert(format(40) { n => n + 2 } == 42);
}

struct EarlyStop {}
struct Later {}
struct Message { first: EarlyStop, second: Later }
enum Either { Stop { first: EarlyStop, second: Later }, Continue { value: i64 } }
fn format(out: u8[>..]&, l: Later) { out.format(later_global); }
fn format(out: u8[>..]&, s: EarlyStop) { return 7 from early; }
fn format(out: u8[>..]&, s: EarlyStop, other: MaybeStop) { abort("wrong overload"); }
fn early(mode: i64, flag: bool) {
    var out: u8[>..] = [];
    fn read() { return later_global; }
    fn jump() -> i64 { if flag { return true from early; } return 3; }
    if mode == 0 { format(out, EarlyStop {}, later_global); }
    if mode == 1 { format(out, EarlyStop {}, read() + 1); }
    if mode == 2 { format(out, EarlyStop {}, if flag { return true; } else { 3 }); }
    if mode == 3 { format(out, EarlyStop {}, jump() + 1); }
    if mode == 4 { print(Message { first: EarlyStop {}, second: Later {} }); }
    if mode == 5 {
        let message: Either = if flag { Either.Stop { first: EarlyStop {}, second: Later {} } }
                              else { Either.Continue { value: 42 } };
        out.format(message);
        assert(out == "Continue { 42 }");
    }
    return 42;
}
let early_results = [early(0, true), early(1, true), early(2, true), early(3, true),
                     early(4, true), early(5, true)];
let later_global: i64 = 8;

fn main() {
    for value in early_results { assert(value == 7); }
    assert(early(5, false) == 42 && str(Later {}) == "8");
    check_format_overload();
    assert(render(true) == 5 && order == 13);
    order = 0;
    assert(render(false) == 7 && order == 123);
    assert(sum(3) == 10);
    for mode in 5 { assert(choose(mode, false) == 7); }
    assert(choose(3, true) == 8);
    assert(choose(5, true) == 7 && choose(5, false) == 42);
    assert(choose(6, true) == 7 && choose(6, false) == 7 && choose(7, false) == 7);
    assert(choose(8, false) == 7 && choose(9, false) == 7);
    print("ok");
}
