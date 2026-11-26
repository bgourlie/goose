// error: cannot infer the element type of []
fn main() {
    var items = [];
    let equal = items == [];
    items.push(1);
    print(equal);
}
