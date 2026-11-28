// xfail: typecheck cannot assign to let x (§4.4)
// The first argument initializes x once, before the third argument borrows it (§4.4).
fn read_after_init(a: i64, b: i64, value: i64&) { assert(value == a + b); }
fn test_branch_argument(flag: bool) {
    let x: i64;
    let y = 42;
    read_after_init(block { x = 42; 40 }, 2, if flag { x } else { y });
}
fn main() {
    test_branch_argument(true);
    test_branch_argument(false);
}
