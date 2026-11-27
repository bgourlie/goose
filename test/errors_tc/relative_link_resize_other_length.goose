// error: retained storage may have a self-relative link to a removed element
struct List { focus: i64&<u32>?, values: i64[>..] }

fn main() {
    var list = List { values: [11, 22, 33] };
    list.focus .= list.values[2];
    var other: i64[>..] = [44];
    list.values.resize(other.len + 1, 0);
}
