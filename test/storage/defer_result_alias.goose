struct Item { counter: i64& }

fn observe(items: Item[]&) { assert(items.len == 1); }
fn increment(counter: i64&) { counter++; }
fn update(items: Item[]&) { increment(items[0].counter); }

fn build(counter: i64&) -> Item[] {
    var items: Item[] = [Item { counter: counter }];
    let alias .= items;
    defer observe(alias);
    defer update(alias);
    return items;
}

fn read_rebound_alias() -> i64[] {
    var result: i64[] = [42];
    var spare: i64[] = [0];
    var observed .= spare;
    let written .= spare[0];
    defer {
        assert(observed[0] == 42);
        written++;
    }
    observed .= result;
    return result;
}

fn stop() -> i64 { abort("stop"); }
fn numbers(n: i64 = stop()) -> i64[] { [n] }
fn fixed_numbers(n: i64) -> i64[2] { [n, stop()] }
struct Linked { n: i64, next: Linked&<u32>? }
fn linked(n: i64) -> Linked { Linked { n: n } }
struct DefaultLinked { n: i64 = stop(), next: DefaultLinked&<u32>? }

fn stopped_push(flag: bool) -> Linked[>..] {
    var out: Linked[>..] = [linked(41)];
    let alias .= out;
    defer { if flag { alias.push(linked(stop())); } }
    defer { if flag { alias.append([linked(stop())]); } }
    defer { if flag { alias.push(Linked { n: stop() }); } }
    defer { if flag { alias.append([Linked { n: stop() }]); } }
    return out;
}

fn stopped_default(flag: bool) -> DefaultLinked[>..] {
    var out: DefaultLinked[>..] = [];
    let alias .= out;
    defer { if flag { alias.push(default<DefaultLinked>()); } }
    return out;
}

fn stopped_store(flag: bool) -> i64[] {
    var out: i64[] = [41];
    let alias .= out[0];
    defer { if flag { alias = stop(); } }
    defer { if flag { alias += stop(); } }
    return out;
}

fn stopped_builtin(flag: bool) -> i64[>..] {
    var out: i64[>..] = [41];
    let alias .= out;
    defer { if flag { alias.pop_n(stop()); } }
    defer { if flag { alias.push(stop()); } }
    defer { if flag { alias.append([1, stop()]); } }
    defer { if flag { alias.append(numbers(stop())); } }
    defer { if flag { alias.append(if flag { numbers(stop()) } else { numbers() }); } }
    defer { if flag { alias.append(fixed_numbers(1)); } }
    defer { if flag { alias.resize(2, stop()); } }
    return out;
}

fn stopped_format(flag: bool) -> u8[>..] {
    var out: u8[>..] = [41];
    let alias .= out;
    defer { if flag { alias.format(stop()); } }
    defer { if flag { alias.append(str(stop())); } }
    defer { if flag { alias.format(Stop {}); } }
    return out;
}

struct Stop {}
struct Message { field: Stop }
fn format(out: u8[>..]&, value: Stop) { abort("stop"); }

fn stopped_limited_format(flag: bool) -> u8[..] {
    var out: u8[..] = [..32];
    let alias .= out;
    defer { if flag { alias.format(Message { field: Stop {} }); } }
    return out;
}

fn copied_source() -> i64[] {
    var source: i64[2] = [41, 42];
    let first .= source[0];
    defer { first++; }
    return source;
}

inline fn copied_growable() -> i64[>..<] {
    var source: i64[>..] = [41];
    let first .= source[0];
    defer { first++; }
    return source;
}

struct Small { value: i64 }
fn make(n: i64) -> Small { Small { value: n } }
fn stopped_aggregate(flag: bool) -> Small[] {
    var result: Small[] = [Small { value: 42 }];
    let first .= result[0];
    defer { if flag { first = make(stop()); } }
    return result;
}

var slot: i64 = 7;
inline fn read_before_store() -> i64 {
    defer { assert(slot == 7); }
    return 42;
}

fn main() {
    var counter = 41;
    let items: Item[] = build(counter);
    assert(items[0].counter == 42 && counter == 42);
    let numbers: i64[] = read_rebound_alias();
    assert(numbers[0] == 42);
    let unchanged = stopped_store(false);
    assert(unchanged[0] == 41);
    assert(stopped_builtin(false)[0] == 41);
    assert(stopped_push(false)[0].n == 41);
    assert(stopped_default(false).len == 0);
    assert(stopped_format(false)[0] == 41);
    assert(stopped_limited_format(false).len == 0);
    assert(copied_source()[0] == 41);
    let copied: i64[>..<] = copied_growable();
    assert(copied[0] == 41);
    assert(stopped_aggregate(false)[0].value == 42);
    slot = read_before_store();
    assert(slot == 42);
    print("ok");
}
