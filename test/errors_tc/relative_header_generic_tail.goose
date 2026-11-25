// error: retained storage may have a self-relative link to a removed element
struct Box<T> { item: T }
struct List { saved: Box<i64>&<u32>?, tail: Box<Box<i64>>[>..] }
fn main() {
    var list = List { tail: [Box { item: Box { item: 42 } }] };
    list.saved .= list.tail[0].item;
    list.tail.clear();
}
