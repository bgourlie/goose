// error: still under construction
struct Slot { key: i64, link: i64&<u32>? }
fn main() {
    var slots: Slot[..3] = [];
    slots.push(Slot { key: block { slots.push(Slot { key: 1 }); break 2; } });
}
