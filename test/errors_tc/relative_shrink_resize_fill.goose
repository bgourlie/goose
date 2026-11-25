// error: retained storage may have a self-relative link to a removed element
struct List { first: i64&<u32>?, data: i64[>..] }

fn fill(list: List&) -> i64 {
    list.first .= list.data[0];
    return 7;
}

fn trim(keep: i64) {
    var list = List { data: [1] };
    list.data.resize(keep, fill(list));
}

fn main() { trim(1); }
