// error: retained storage may have a self-relative link to a removed element
struct List { focus: i64&<u32>?, values: i64[>..] }

const MASK = ~4;

fn main() {
    var list = List { values: [11, 22] };
    list.focus .= list.values[1];
    const K: u8 = 2;
    list.values.resize(list.values.len + (MASK / K), 73);
    list.values.pop_n(126);
}
