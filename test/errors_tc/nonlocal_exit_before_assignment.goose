// error: variable x may be used before it is assigned
fn main() {
    let x: i64;
    fn outer(early: bool) {
        fn inner() {
            if early { return from outer; }
            x = 1;
        }
        inner();
    }
    outer(true);
    print(x);
}
