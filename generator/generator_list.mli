(* containers for generated code, with i/o functions *)

type 'a t = {
    add           : 'a -> unit;
    add_from_file : string -> unit;
    write         : string -> unit;
  }

val make
   : (Lexing.lexbuf -> 'a list)
  -> (Format.formatter -> 'a list -> unit)
  -> 'a t
