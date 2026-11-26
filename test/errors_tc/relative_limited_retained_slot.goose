// error: retained storage may have a self-relative link to a removed element
struct Link { p: i64&<u32>? }
struct List { saved: Link&<u32>?, head: Link[..2], data: i64[>..] }

fn main() {
    var xs = List { head: [Link {}], data: [42] };
    xs.head[0].p .= xs.data[0];
    xs.saved .= xs.head[0];
    xs.head = [];
    xs.data.clear();
}
