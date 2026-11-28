// error: retained storage may have a self-relative link to a removed element
struct List { focus: i64&<u32>?, values: i64[>..] }

fn main() {
    var first = List { values: [11, 22, 33] };
    var second = List { values: [44] };
    first.focus .= first.values[2];
    var selected .= first;
    selected.values.resize((block { selected .= second; break 1; }) + selected.values.len, 7);
}
