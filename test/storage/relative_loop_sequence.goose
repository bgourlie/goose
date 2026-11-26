struct Node { next: Node&<u32>? }
struct Pair { items: Node[2] = [Node {}, Node {}] }
struct List { header: Node[2] = [Node {}, Node {}], rows: Pair[>..] }

fn chosen(pair: Pair&) -> Pair& { pair }

fn main() {
    var data = List { rows: [Pair {}, Pair {}] };
    {
        var pair .= data.rows[0];
        for &node in pair.items {
            node.next .= data.rows[1].items[0];
            pair .= data.rows[1];
        }
        assert(data.rows[1].items[1].next .== data.rows[1].items[0]);
    }
    {
        let index: i64;
        for &node in data.rows[block { index = 0; index }].items {
            node.next .= data.rows[1].items[0];
        }
        assert(index == 0);
    }
    {
        var pair .= data.rows[0];
        let called: bool;
        for &node in chosen(block { called = true; pair }).items {
            node.next .= data.header[0];
            pair .= data.rows[1];
        }
        assert(called && data.rows[0].items[1].next .== data.header[0]);
        assert(data.rows[1].items[1].next .== data.rows[1].items[0]);
    }
    {
        var view = data.rows[0].items[..];
        let evaluated: bool;
        for &node in block { evaluated = true; view } {
            node.next .= data.rows[1].items[0];
            view = data.header[..];
        }
        assert(evaluated && data.header[1].next == null);
    }
    data.rows.clear();
    print("ok");
}
