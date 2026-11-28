struct Node { next: Node&<u32>? }
struct List { rows: Node[>..] }
struct Table { list: List }

fn make_table() -> Table { Table { list: List { rows: [Node {}; 4] } } }

fn constructed_lengths() {
    var rows: Node[>..] = [];
    rows = [Node {}; 4];
    rows[0].next .= rows[1];
    rows.pop_n(2);
    assert(rows.len == 2 && rows[0].next .== rows[1]);

    var table = make_table();
    table.list.rows[0].next .= table.list.rows[1];
    table.list.rows.pop_n(2);
    assert(table.list.rows[0].next .== table.list.rows[1]);

    table.list.rows = [Node {}; 4];
    table.list.rows[0].next .= table.list.rows[1];
    table.list.rows.pop_n(2);
    assert(table.list.rows.len == 2 && table.list.rows[0].next .== table.list.rows[1]);
}

fn loop_bounds(flag: bool) {
    var rows: Node[>..] = [Node {}; 2];
    rows[0].next .= rows[1];
    let data = [1, 2, 3, 4];
    rows.append([Node {}; 2]);
    for x in data[1..3] { rows.pop(); }
    assert(rows.len == 2 && rows[0].next .== rows[1]);

    const window = data[1..3];
    rows.append([Node {}; 2]);
    for x in window { rows.pop(); }
    assert(rows.len == 2 && rows[0].next .== rows[1]);

    const n: i64 = if flag { 1 } else { 2 };
    rows.append([Node {}; 2]);
    for i in n { rows.pop(); }
    assert(rows.len == (if flag { 3 } else { 2 }) && rows[0].next .== rows[1]);
}

fn main() {
    constructed_lengths();
    loop_bounds(true);
    loop_bounds(false);
    print("ok");
}
