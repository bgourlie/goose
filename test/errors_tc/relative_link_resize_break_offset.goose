// error: retained storage may have a self-relative link to a removed element
struct List { focus: i64&<u32>?, values: i64[>..] }
let adjustment = 1;

fn main() {
    let writable .= adjustment;
    writable = -1;
    var list = List { values: [11, 22] };
    list.focus .= list.values[1];
    let extra = loop { break adjustment; };
    list.values.resize(list.values.len + extra, 0);
}
