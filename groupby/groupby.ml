(* Three implementations of group-by-length for words in the system dictionary *)
open Core.Std
(* open Core_bench.Std *)

let dict = "/usr/share/dict/american-english"

let verbose () =
  dict
  |> In_channel.read_lines
  |> List.sort ~cmp:(fun x y -> (String.length x) - (String.length y))
  |> List.group ~break:(fun m n -> not (Int.equal (String.length m) (String.length n)))
  |> Array.of_list_map ~f:(fun x->(String.length (List.hd_exn x), x))
  |> Map.of_sorted_array_unchecked ~comparator:Int.comparator

let using_map () =
  let find m k = match Map.find m k with None -> [] | Some x -> x in
  dict
  |> In_channel.read_lines
  |> List.fold ~init:(Map.empty Int.comparator) ~f:(fun ac x -> (Map.add ac (String.length x) (x::(find ac (String.length x)))))

let using_hashtbl () =
  let find h k = match Hashtbl.find h k with None -> [] | Some x -> x in
  let h = Hashtbl.create ~hashable:Int.hashable () in
  dict
  |> In_channel.read_lines
  |> List.iter ~f:(fun x->(Hashtbl.set h (String.length x) (x::(find h (String.length x)))));
  (* h *) (* would normally be returned, but we return an empty map to conform with the type signature of the other two benchmarks *)
  Hashtbl.length h

let () =
  for i = 1 to 100 do
    printf "%d\n" (using_hashtbl ())
  done
(* let () = *)
(*   let test name fn = Bench.Test.create ~name:name fn in *)
(*   let tests = List.map2_exn ["verbose"; "Map"; "Hashtbl"] [verbose; using_map; using_hashtbl] test in *)
(*   Bench.make_command tests *)
(*   |> Command.run *)
