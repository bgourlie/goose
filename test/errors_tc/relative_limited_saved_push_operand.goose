// error: a reference into it was stored there
struct Slot { link: i64&? }

fn main() {
    var values: i64[>..] = [42];
    var slots: Slot[..2] = [Slot {}];
    const n = slots.len;
    slots.push(block { slots.resize(n); break Slot {}; });
    slots[0].link .= values[0];
    slots.pop_n(n);
    values.clear();
    assert(slots.len == 1);
}
