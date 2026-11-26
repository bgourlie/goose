// error: retained storage may have a self-relative link to a removed element
struct Node { next: Node&<u32>? }
struct Pair { items: Node[2] = [Node {}, Node {}] }
struct List { header: Pair, rows: Pair[>..] }

fn main() {
    var list = List { header: Pair {}, rows: [Pair {}] };
    {
        var pair .= list.rows[0];
        for &node in pair.items {
            node.next .= list.rows[0].items[1];
            pair .= list.header;
            continue;
        }
    }
    list.rows.clear();
}
