// xfail: typecheck cannot assign to let x (§4.4)
// The first argument initializes x before the second argument chooses which value to borrow (§4.4).
fn read_after_init(expected: i64, value: i64&) { assert(value == expected); }
fn test_branch_argument(flag: bool, expected: i64) {
    let x: i64;
    let y = 17;
    read_after_init(block { x = 42; expected }, if flag { x } else { y });
}
fn main() {
    test_branch_argument(true, 42);
    test_branch_argument(false, 17);
}
