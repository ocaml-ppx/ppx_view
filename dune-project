(lang dune 1.11)
(name ppx_view)

(generate_opam_files true)
(implicit_transitive_deps false)

(license Apache-2.0)
(maintainers "Xavier Clerc")
(authors "Xavier Clerc")
(source (github ocaml-ppx/ppx_view))

(package
 (name ppx_view)
 (synopsis "")
 (description "A ppx rewriter that provides pattern matching on abstract types by
transforming patterns into views/expressions.")
 (depends
  dune
  ocaml-migrate-parsetree
  (ppx_expect :with-test)))
