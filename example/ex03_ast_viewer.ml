open Migrate_parsetree.Ast_404
open Viewast


let twice_mapper =
  let module H = Ast_helper in
  let module M = Ast_mapper in
  let module V = Ast_viewer in
  let super = M.default_mapper in
  let expr self e =
    match%view super.expr self e with
    | V.Exp.Constant (V.Const.String (str, _)) ->
      H.Exp.constant (H.Const.string (str ^ str))
    | other ->
      other
  and pat self p =
    match%view super.pat self p with
    | V.Pat.Constant (V.Const.String (str, _)) ->
      H.Pat.constant (H.Const.string (str ^ str))
    | other ->
      other
  in
  { super with expr; pat; }


let run () =
  let open Location in
  let open Longident in
  let nil =
    Ast_helper.Exp.construct
      { txt = Lident "[]"; loc = Location.none; }
      None
  in
  let cons hd tl =
    Ast_helper.Exp.construct
      { txt = Lident "::"; loc = Location.none; }
      (Some (Ast_helper.Exp.tuple [hd; tl]))
  in
  let abc =
    Ast_helper.Exp.constant
      (Ast_helper.Const.string "abc")
  in
  let def =
    Ast_helper.Exp.constant
      (Ast_helper.Const.string "def")
  in
  let abc_def =
    cons abc (cons def nil)
  in
  let abc_def =
    [Ast_helper.Str.eval abc_def] in
  let print fmt structure =
    Pprintast.structure fmt structure;
    Format.pp_print_newline fmt ();
    Format.pp_print_flush fmt ()
  in
  let fmt = Format.std_formatter in
  print fmt abc_def;
  print fmt (twice_mapper.structure twice_mapper abc_def)
