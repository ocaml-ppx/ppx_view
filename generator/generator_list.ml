type 'a t = {
    add           : 'a -> unit;
    add_from_file : string -> unit;
    write         : string -> unit;
  }

let make reader_func writer_func =
  let items = ref [] in
  let add item =
    items := item :: !items
  in
  let add_list item_list =
    items := (List.rev item_list) @ !items
  in
  let add_from_file path =
    let full_path = Filename.concat !Generator_args.data_path path in
    let chan = open_in full_path in
    let lexbuf = Lexing.from_channel chan in
    let file_items = reader_func lexbuf in
    add_list file_items;
    close_in chan
  in
  let write path =
    let full_path = Filename.concat !Generator_args.dest_path path in
    let chan = open_out full_path in
    let fmt = Format.formatter_of_out_channel chan in
    writer_func fmt (List.rev !items);
    Format.pp_print_newline fmt ();
    Format.pp_print_flush fmt ();
    close_out chan
  in
  { add; add_from_file; write; }
