// xfail: stdout-O2 42
// The defer reads the previous slot value before the caller assigns the result (§§4.4, 6.6).
struct Small { value: i64 }
var slot = Small { value: 7 };

inline fn change() -> Small {
    defer { print(slot.value); }
    return Small { value: 42 };
}

fn main() {
    slot = change();
    assert(slot.value == 42);
}
