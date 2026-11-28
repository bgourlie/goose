struct Node { next: Node&<u32>? }
struct Trim {}
var nodes: Node[>..] = [Node {}; 2];

fn format(out: u8[>..]&, _: Trim) { nodes.pop(); out.push(88); }
fn show_pair() -> u8[>..] { str([Trim {}; 2]) }
fn take_slot() -> i64 { nodes.pop(); return 42; }
struct Item { n: i64 = take_slot() }
struct Mark {}
fn format(out: u8[>..]&, _: Mark) { out.push(65); out.pop(); out.push(66); }
struct Label { n: i64 = { let text = str(Mark {}); text.len } }

fn main() {
    nodes[0].next .= nodes[1];
    let empty: Trim[..0] = [];
    assert(str(empty) == "[]" && nodes.len == 2);
    let trims: Trim[..2] = [Trim {}; 2];
    nodes.append([Node {}; 2]);
    assert(str(trims) == "[X, X]" && nodes[0].next .== nodes[1]);
    nodes.append([Node {}; 2]);
    assert(str([Trim {}; 2]) == "[X, X]");
    assert(nodes.len == 2 && nodes[0].next .== nodes[1]);
    nodes.append([Node {}; 3]);
    assert(show_pair() == "[X, X]");
    nodes.pop();
    assert(nodes.len == 2 && nodes[0].next .== nodes[1]);
    nodes.append([Node {}; 4]);
    assert(str([[Trim {}; 2]; 2]) == "[[X, X], [X, X]]");
    nodes.append([Node {}; 2]);
    let items = default<Item[2]>();
    assert(items[1].n == 42 && nodes.len == 2);
    reusable[] var pool: Item[>..] = [];
    nodes.append([Node {}; 2]);
    let pair = pool.alloc_slice(2);
    nodes.append([Node {}; 3]);
    let grown = pool.realloc_slice(pair, 3);
    assert(grown[2].n == 42 && nodes.len == 4 && nodes[0].next .== nodes[1]);
    let labels = default<Label[2]>();
    assert(labels[0].n == 1 && labels[1].n == 1);
    print("ok");
}
