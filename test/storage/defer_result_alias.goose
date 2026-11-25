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
fn stopped_store(flag: bool) -> i64[] {
    var out: i64[] = [41];
    let alias .= out[0];
    defer { if flag { alias = stop(); } }
    defer { if flag { alias += stop(); } }
    return out;
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
    slot = read_before_store();
    assert(slot == 42);
    print("ok");
}
