struct Bytes { cursor: const u8&<u32>?, header: u16[2], tail: u8[>..] }
struct Entry { n: i64, p: i64&<u32>? }
struct Container { prefix: Entry[], tail: i64[>..] }

fn records() -> Entry[] {
    var xs: Entry[] = [Entry { n: 17 }, Entry { n: 23 }];
    xs[0].p .= xs[1].n;
    return xs;
}

fn main() {
    var b = Bytes { header: [17, 99], tail: [30, 40] };
    b.cursor .= b.header.bytes_of()[1];
    b.tail.clear();
    assert(b.cursor .== b.header.bytes_of()[1]);

    var c = Container { prefix: records(), tail: [30, 40] };
    c.tail.clear();
    assert(c.prefix[0].p .== c.prefix[1].n);
    print("ok");
}
