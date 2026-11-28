// xfail: typecheck cannot assign to let called (§4.4)
// The call that produces the sequence evaluates its argument once (§6.5).
struct Pair { items: i64[2] }
fn chosen(pair: Pair&) -> Pair& { pair }
fn main() {
    var pair = Pair { items: [3, 7] };
    let called: bool;
    var sum = 0;
    for node in chosen(block { called = true; pair }).items { sum += node; }
    assert(called && sum == 10);
}
