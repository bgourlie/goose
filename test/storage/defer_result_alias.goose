struct Item { counter: i64& }

fn observe(items: Item[]&) { assert(items.len == 1); }
fn increment(counter: i64&) { counter++; }
fn increment_first(view: i64[:]) { view[0]++; }
fn update(items: Item[]&) { increment(items[0].counter); }

fn prepare_in_inner_scopes() -> i64[] {
    var out: i64[] = [1];
    let first .= out[0];
    { defer { first++; } }
    for i in 3 {
        defer increment(first);
        if i == 0 { continue; }
        break;
    }
    assert(out[0] == 4);
    return out;
}

fn prepare_later_result() -> i64, i64[>..] {
    var out: i64[>..] = [1];
    let alias .= out;
    return block { defer { alias.push(2); } 7 }, out;
}

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

fn moved_before_exit(later_defer: bool) -> i64[] {
    var out: i64[] = [42];
    var spare = 0;
    var written .= out[0];
    defer increment(written);
    if later_defer {
        defer { written .= spare; }
    } else {
        written .= spare;
    }
    return out;
}

fn moved_during_unwind() -> i64[] {
    var out: i64[] = [42];
    var spare = 0;
    var written .= out[0];
    defer { written++; }
    defer { written .= spare; }
    return out;
}

fn skipped_rebind(skip: bool) -> i64[] {
    var out: i64[] = [42];
    var spare = 0;
    var target .= spare;
    let first .= out[0];
    fn stop_after_rebind() -> bool { target .= first; abort("stop"); }
    let skipped = skip || stop_after_rebind();
    defer { target++; }
    return out;
}

fn moved_on_nonlocal_exit() -> i64[] {
    var out: i64[] = [42];
    var spare = 0;
    var target .= spare;
    let first .= out[0];
    fn phase() {
        fn leave() { target .= first; return from phase; }
        defer { target .= spare; }
        leave();
    }
    phase();
    defer { target++; }
    return out;
}

fn moved_slice(in_helper: bool) -> i64[] {
    var out: i64[] = [42];
    var spare: i64[] = [0];
    let input: i64[1] = [10];
    var view: i64[:] = out[..];
    fn move() { view = spare[..]; }
    if in_helper { move(); } else { view = spare[..]; }
    defer { assert(spare[0] == 12); }
    defer increment_first(view);
    defer { view[0]++; }
    defer { view.move_from(input[..]); }
    return out;
}

fn stop() -> i64 { abort("stop"); }
fn stopped_array() -> i64[] { abort("stop"); }
fn stopped_empty() -> i64[] { defer { abort("stop"); } return []; }
fn empty_array() -> i64[] { [] }
fn forward_empty() -> i64[] { empty_array() }
fn stopped_forwarded_empty() -> i64[] { defer { abort("stop"); } return forward_empty(); }
fn stopped_empty_branches(flag: bool) -> i64[] {
    defer { abort("stop"); }
    return if flag { block { [] } } else { loop { break []; } };
}
fn stopped_first() -> i64[] { [stop()] }
fn forward_stopped() -> i64[] { stopped_first() }
fn stopped_local(n: i64) -> i64[] {
    var result: i64[] = [n, stop()];
    return result;
}
fn numbers(n: i64 = stop()) -> i64[] { [n] }
fn fixed_numbers(n: i64) -> i64[2] { [n, stop()] }
struct Linked { n: i64, next: Linked&<u32>? }
fn linked(n: i64) -> Linked { Linked { n: n } }
struct DefaultLinked { n: i64 = stop(), next: DefaultLinked&<u32>? }
struct FillItem { n: i64, other: i64, next: FillItem&<u32>? }

fn stopped_fill(flag: bool) -> FillItem[>..] {
    var out: FillItem[>..] = [FillItem { n: 41, other: 0 }];
    let alias .= out;
    defer { if flag { alias.append([FillItem { n: 1, other: stop() }; 2]); } }
    return out;
}

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
    defer { if flag { alias.append(stopped_array()); } }
    defer { if flag { alias.append(stopped_empty()); } }
    defer { if flag { alias.append(stopped_forwarded_empty()); } }
    defer { if flag { alias.append(stopped_empty_branches(flag)); } }
    defer { if flag { alias.append(forward_stopped()); } }
    defer { if flag { alias.append(stopped_local(7)); } }
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

struct Bag { count: i64, items: i64[>..] }
struct Envelope { serial: i64, bag: Bag }

fn update_bag(bag: Bag&) { increment(bag.count); }
fn update_envelope(box: Envelope&) { update_bag(box.bag); }
fn select_field(flag: bool, a: i64&, b: i64&) -> i64& { if flag { a } else { b } }

fn copied_fields(flag: bool) -> Envelope {
    var box = Envelope { serial: 5, bag: Bag { count: 7, items: [42] } };
    let serial .= box.serial;
    let count .= box.bag.count;
    let alias .= box;
    let selected: i64& = if flag { box.serial } else { box.bag.count };
    let other .= select_field(flag, box.bag.count, box.serial);
    defer {
        serial++;
        increment(count);
        update_envelope(alias);
        assert(serial == 6 && count == 9);
        selected++;
        increment(other);
        assert(serial == 7 && count == 10);
    }
    return box;
}

fn increment_or_scratch(flag: bool, value: i64&) {
    var scratch = 0;
    let target: i64& = if flag { value } else { scratch };
    target++;
}

fn mixed_owners(flag: bool) -> Bag {
    var bag = Bag { count: 7, items: [42] };
    var other = 5;
    let header .= bag.count;
    let direct: i64& = if flag { bag.count } else { other };
    let through_call .= select_field(flag, other, bag.count);
    defer {
        direct++;
        increment(through_call);
        assert(header == 8 && other == 6);
    }
    return bag;
}

fn mixed_tail_owner(flag: bool) -> Bag {
    var bag = Bag { count: 7, items: [42] };
    var spare = Bag { count: 0, items: [10] };
    let header .= bag.count;
    var target .= bag.count;
    if flag { target .= spare.items[0]; }
    defer {
        target++;
        increment_or_scratch(flag, header);
        assert(header == 8);
        if flag { assert(spare.items[0] == 11); }
    }
    return bag;
}

struct Small { value: i64 }
fn make(n: i64) -> Small { Small { value: n } }
fn stopped_small() -> Small { abort("stop"); }
fn stopped_linked() -> Linked { Linked { n: stop() } }
fn inferred_stopped_linked() { return Linked { n: stop() }; }

fn stopped_placed_call(flag: bool) -> Linked[] {
    var result: Linked[] = [Linked { n: 42 }];
    let first .= result[0];
    defer { if flag { first = stopped_linked(); } }
    defer { if flag { first = inferred_stopped_linked(); } }
    return result;
}

fn stopped_aggregate(flag: bool) -> Small[] {
    var result: Small[] = [Small { value: 42 }];
    let first .= result[0];
    defer { if flag { first = make(stop()); } }
    defer { if flag { first = stopped_small(); } }
    defer {
        if flag {
            first = block {
                defer { abort("stop"); }
                Small { value: 7 }
            };
        }
    }
    return result;
}

var slot: i64 = 7;
inline fn read_before_store() -> i64 {
    defer { assert(slot == 7); }
    return 42;
}

fn main() {
    assert(prepare_in_inner_scopes()[0] == 4);
    let n, prepared = prepare_later_result();
    assert(n == 7 && prepared.len == 2 && prepared[1] == 2);
    var counter = 41;
    let items: Item[] = build(counter);
    assert(items[0].counter == 42 && counter == 42);
    let numbers: i64[] = read_rebound_alias();
    assert(numbers[0] == 42);
    assert(moved_before_exit(false)[0] == 42);
    assert(moved_before_exit(true)[0] == 42);
    assert(moved_during_unwind()[0] == 42);
    assert(skipped_rebind(true)[0] == 42);
    assert(moved_on_nonlocal_exit()[0] == 42);
    assert(moved_slice(true)[0] == 42 && moved_slice(false)[0] == 42);
    assert(stopped_placed_call(false)[0].n == 42);
    let unchanged = stopped_store(false);
    assert(unchanged[0] == 41);
    assert(stopped_builtin(false)[0] == 41);
    assert(stopped_push(false)[0].n == 41);
    assert(stopped_fill(false)[0].n == 41);
    assert(stopped_default(false).len == 0);
    assert(stopped_format(false)[0] == 41);
    assert(stopped_limited_format(false).len == 0);
    assert(copied_source()[0] == 41);
    let copied: i64[>..<] = copied_growable();
    assert(copied[0] == 41);
    for flag in [false, true] {
        let box = copied_fields(flag);
        assert(box.serial == 5 && box.bag.count == 7 && box.bag.items[0] == 42);
        let bag = mixed_owners(flag);
        assert(bag.count == 7 && bag.items[0] == 42);
        assert(mixed_tail_owner(flag).count == 7);
    }
    assert(stopped_aggregate(false)[0].value == 42);
    slot = read_before_store();
    assert(slot == 42);
    print("ok");
}
