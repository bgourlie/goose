// error: retained storage may have a self-relative link to a removed element
struct Buffer { cursor: const u8&<u32>?, data: i64[>..] }

fn main() {
    var buffer = Buffer { data: [7, 8] };
    buffer.cursor .= buffer.data.bytes_of()[1];
    buffer.data.clear();
}
