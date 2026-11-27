// error: defer body writes through an alias to out
fn both() -> i64[>..], i64 {
    var out: i64[>..] = [7];
    let alias .= out;
    return out, block { defer { alias.push(99); } 1 };
}

fn main() { var values, n = both(); print(values, n); }
