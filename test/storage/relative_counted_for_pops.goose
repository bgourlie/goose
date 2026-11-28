struct Node { next: Node&<u32>? }
var nodes: Node[>..] = [Node {}; 2];

fn trim_pair(skip: bool) {
    for i in 2 {
        defer { nodes.pop(); }
        if skip { continue; }
    }
}
fn trim_until(stop: bool) {
    for i in -1..1 {
        nodes.pop();
        if stop { break; }
    }
}
fn conditional_counts(flag: bool) {
    var rows: Node[>..] = [Node {}; 2];
    rows[0].next .= rows[1];
    rows.append([Node {}; 2]);
    for i in if flag { 1 } else { 2 } { rows.pop(); }
    assert(rows.len == (if flag { 3 } else { 2 }) && rows[0].next .== rows[1]);
    const ONE: u8 = 1;
    const TWO: u8 = 2;
    rows.append([Node {}; 2]);
    for i in if flag { TWO } else { ONE } { rows.pop(); }
    assert(rows.len == 3);
    rows.append([Node {}; 2]);
    for i: i8 in (if flag { -1 } else { 0 })..(if flag { 1 } else { 0 }) { rows.pop(); }
    assert(rows.len == (if flag { 3 } else { 5 }) && rows[0].next .== rows[1]);
    rows.append([Node {}; 2]);
    for i in if flag { return; } else { TWO } { rows.pop(); }
    assert(rows.len == 5 && rows[0].next .== rows[1]);
}
fn assigned_in_wide_range(short: bool) -> i64 {
    var value: i64;
    for i in (if short { 0 } else { -9223372036854775808 })..2 { value = 42; }
    return value;
}
fn main() {
    assert(assigned_in_wide_range(true) == 42);
    conditional_counts(true);
    conditional_counts(false);
    nodes[0].next .= nodes[1];
    nodes.append([Node {}; 2]);
    for i in 2 { nodes.pop(); }
    assert(nodes.len == 2 && nodes[0].next .== nodes[1]);
    nodes.append([Node {}; 2]);
    trim_pair(true);
    nodes.append([Node {}; 2]);
    trim_until(false);
    assert(nodes.len == 2);

    const COUNT: u8 = 2;
    nodes.append([Node {}; 2]);
    for i in COUNT { nodes.pop(); }
    assert(nodes.len == 2 && nodes[0].next .== nodes[1]);

    let fixed = [4, 5];
    let limited: i64[..2] = [1];
    nodes.append([Node {}; 4]);
    for x in fixed { nodes.pop(); }
    for x in limited { nodes.pop(); }
    assert(nodes.len == 3 && nodes[0].next .== nodes[1]);
    print("ok");
}
