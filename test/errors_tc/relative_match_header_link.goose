// error: retained storage may have a self-relative link to a removed element
struct Node { value: i64 }
enum Entry { Part { item: Node }, Empty }
struct List { first: Node&<u32>?, entries: Entry..[>..] }

fn main() {
    var list = List { entries: [] };
    list.entries.push(Entry.Part { item: Node { value: 1 } });
    for entry in list.entries {
        match entry {
            Part &p => { list.first .= p.item; },
            Empty => {}
        }
    }
    list.entries.clear();
}
