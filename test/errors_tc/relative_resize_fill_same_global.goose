// error: retained storage may have a self-relative link to a removed element
struct List { focus: i64&<u32>?, values: i64[>..] }
var list = List { values: [11, 22] };

fn extend(other: List&) {
    fn fill() -> i64 {
        other.values.push(33);
        other.values.push(44);
        other.focus .= other.values[3];
        return 7;
    }
    list.values.resize(list.values.len + 1, fill());
}

fn main() { extend(list); }
