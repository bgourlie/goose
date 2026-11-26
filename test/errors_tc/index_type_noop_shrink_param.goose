// error: an index type names nodes
var nodes: i32[>..] = [];
type NodeId = u32 in nodes;
fn keep(a: i32[>..]&) { a.pop_n(0); }
fn main() { keep(nodes); }
