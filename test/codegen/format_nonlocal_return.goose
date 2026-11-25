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

fn main() {
    assert(render(true) == 5 && order == 13);
    order = 0;
    assert(render(false) == 7 && order == 123);
    assert(sum(3) == 10);
    print("ok");
}
