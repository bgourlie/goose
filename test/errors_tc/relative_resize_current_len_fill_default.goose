// error: retained storage may have a self-relative link to a removed element
struct Point { x: i64 = grow() }
struct List { cursor: Point&<u32>?, values: Point[>..] }
var list = List { values: [Point { x: 42 }] };

fn grow() -> i64 {
    list.values.push(Point { x: 7 });
    list.cursor .= list.values[1];
    return 0;
}

fn main() { list.values.resize(list.values.len, Point {}); }
