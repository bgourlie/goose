// error: defer body writes through an alias to out, which build returns by name
struct Holder { p: i64& }

fn replace(h: Holder&, target: i64&) {
    defer { h.p++; }
    h.p .= target;
}

fn build() -> i64[] {
    var out: i64[] = [1];
    var spare: i64[] = [2];
    var h = Holder { p: spare[0] };
    let alias .= out;
    defer replace(h, alias[0]);
    return out;
}
fn main() { print(build()); }
