struct NumberList { focus: i64&<u32>?, values: i64[>..] }

root struct State { other: NumberList, value: i64 = 0 }

var global_numbers = NumberList { values: [11, 22] };

fn extend_global(other: NumberList&) {
    fn fill() -> i64 { other.values.push(17); return 33; }
    global_numbers.values.resize(global_numbers.values.len + 2, fill());
}

fn extend_from_component(state: State&) {
    fn fill() -> i64 { state.other.values.push(42); return 7; }
    global_numbers.values.resize(global_numbers.values.len + 2, fill());
}

fn main() {
    var list = NumberList { values: [11, 22] };
    list.focus .= list.values[1];
    global_numbers.focus .= global_numbers.values[1];
    extend_global(list);
    global_numbers.values.pop_n(2);
    assert(global_numbers.focus .== global_numbers.values[1]);
    list.values.pop();
    assert(list.values.len == 2 && list.focus .== list.values[1]);
    var state = State { other: NumberList { values: [11, 22] } };
    extend_from_component(state);
    global_numbers.values.pop_n(2);
    assert(state.other.values.len == 3 && global_numbers.focus .== global_numbers.values[1]);
    print("ok");
}
