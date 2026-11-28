// error: retained storage may have a self-relative link to a removed element
struct List { focus: i64&<u32>?, values: i64[>..] }

fn main() {
    var list = List { values: [11, 22] };
    list.focus .= list.values[1];
    const K: u8 = 250;
    list.values.resize(list.values.len + (K + 10), 73);
    list.values.pop_n(5);
}
