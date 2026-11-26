// error: retained storage may have a self-relative link to a removed element
struct Link { p: i64&<u32>? }
struct Header { slots: Link[..2] }
struct List { saved: Link&<u32>?, header: Header, data: i64[>..] }

fn replace(header: Header&) { header = Header { slots: [] }; }
fn main() {
    var xs = List { header: Header { slots: [Link {}, Link {}] }, data: [42] };
    xs.header.slots[1].p .= xs.data[0];
    xs.saved .= xs.header.slots[1];
    replace(xs.header);
    xs.data.clear();
}
