// error: retained storage may have a self-relative link to a removed element
struct Link { next: Link&<u32>? }
struct Row { links: Link[1] = [Link {}] }

fn main() {
    var rows: Row[>..] = [Row {}, Row {}];
    {
        var active .= rows[0].links;
        fn switch_row() -> Link[1]& {
            active .= rows[1].links;
            return active;
        }
        active[0].next .= switch_row()[0];
    }
    rows.pop_n(1);
}
