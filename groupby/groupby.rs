use std::io::prelude::*;
use std::fs::File;
use std::collections::hash_map::HashMap;

fn benchmark(filename:&str) {
    let mut f = File::open(filename).unwrap();
    let mut buf = String::new();
    let n = f.read_to_string(&mut buf).unwrap();
    println!("Read {} bytes.", n);

    let l = buf.lines();
    let mut m = HashMap::new();
    for word in l {
        let w = m.entry(word.len()).or_insert(vec![]);
        w.push(word);
    }
    
    for (k,v) in &m {
        println!("{} words of length {}.", v.len(), k);
    }
}

fn main() {
    let filename = "/usr/share/dict/american-english";
    for _ in 1..100 {
        benchmark(&filename)
    }
}

