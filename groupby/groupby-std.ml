let main file =
  let f = open_in file in
  let h = Hashtbl.create 30 in
  let rec parse_line () =
    try
      let line = input_line f in
      Hashtbl.add h (String.length line) line;
      parse_line ()
    with e ->
      close_in f;
      h in
  parse_line ()

let () =
  for i = 1 to 100 do
    let s = Hashtbl.stats (main "/usr/share/dict/american-english") in
    print_int s.num_bindings
  done
