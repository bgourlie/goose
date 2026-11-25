struct Node { value: i64 }
enum Entry { Part { item: Node, next: Node&<u32>? }, Empty }
struct List { head: Node, first: Node&<u32>?, entries: Entry..[>..] }

fn main() {
    var list = List { head: Node { value: 1 }, entries: [] };
    list.entries.push(Entry.Part { item: Node { value: 2 } });
    list.entries.push(Entry.Empty);
    for entry in list.entries {
        match entry {
            Part &p => { p.next .= list.head; assert(p.next .== list.head); },
            Empty => {}
        }
    }
    list.entries.clear();
    assert(list.entries.len == 0 && list.first == null);
    print("ok");
}
