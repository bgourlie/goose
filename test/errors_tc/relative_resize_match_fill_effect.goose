// error: retained storage may have a self-relative link to a removed element
struct List { head: i64&<u32>?, values: i64[>..] }

fn grow(list: List&) -> i64 {
    list.values.push(7);
    list.head .= list.values[1];
    return 0;
}

fn resize(list: List&, i: i64) {
    list.values.resize(list.values.len, match i { 0 => 17, _ => grow(list) });
}

fn main() {
    var list = List { values: [42] };
    resize(list, 1);
}
