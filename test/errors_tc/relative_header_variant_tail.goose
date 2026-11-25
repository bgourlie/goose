// error: retained storage may have a self-relative link to a removed element
enum Entry { Part { value: i64 }, Empty }
struct List { saved: Entry.Part&<u32>?, entries: Entry..[>..] }
fn main() {
    var list = List { entries: [Entry.Part { value: 42 }] };
    for entry in list.entries {
        match entry {
            Part &p => { list.saved .= p; },
            Empty => {}
        }
    }
    list.entries.clear();
}
