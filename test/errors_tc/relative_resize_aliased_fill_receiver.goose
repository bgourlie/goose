// error: retained storage may have a self-relative link to a removed element
struct List { head: i64&<u32>?, values: i64[>..] }

fn resize(list: List&, other: List&) {
    fn fill() -> i64 {
        other.values.push(17);
        other.head .= other.values[1];
        return 33;
    }
    list.values.resize(list.values.len, fill());
}

fn main() {
    var list = List { values: [11] };
    resize(list, list);
}
