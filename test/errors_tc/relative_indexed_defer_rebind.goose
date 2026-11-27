// error: a defer on this exit can observe bag partially rebuilt
struct Bag { tag: i64, xs: i64[>..] }
struct Slot { link: i64& }

fn replace(stop: bool) {
    var bag = Bag { tag: 9, xs: [1] };
    var other = 7;
    var slots = [[Slot { link: other }], [Slot { link: other }]];
    slots[0][0].link .= bag.tag;
    var row .= slots[0];
    defer { print(row[{ row .= slots[1]; 0 }].link); }
    bag = Bag { tag: 8, xs: [2, if stop { return; } else { 3 }] };
}

fn main() { replace(true); }
