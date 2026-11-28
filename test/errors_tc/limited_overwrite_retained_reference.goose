// xfail: accepts-invalid
// error: cannot clear values while saved is still used
// The limited array retains slot 1 beyond its new length. The saved reference still reaches it (§5.3).
struct Entry { value: i64&? }

fn main() {
    var values: i64[>..] = [42];
    var slots: Entry[..2] = [Entry {}, Entry {}];
    slots[1].value .= values[0];
    let saved .= slots[1];
    slots = [Entry {}];
    values.clear();
    print(saved.value);
}
