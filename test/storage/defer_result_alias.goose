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

fn main() {
    var counter = 41;
    let items: Item[] = build(counter);
    assert(items[0].counter == 42 && counter == 42);
    let numbers: i64[] = read_rebound_alias();
    assert(numbers[0] == 42);
    print("ok");
}
