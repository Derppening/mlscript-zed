; Highlighting for MLscript.
;
; Ported from `queries/highlights.scm` in tree-sitter-mlscript, with two
; changes for Zed:
;
;   * capture names are remapped to the set Zed's themes define (`@property`,
;     `@variable.special`, `@comment.doc`, `@boolean`, `@preproc`, ...);
;   * the order is inverted. Zed keeps the *last* capture that matches a node,
;     so the catch-all `(identifier)` patterns come first and the specific ones
;     override them -- the opposite of the Neovim convention the source file
;     follows.

; ---------------------------------------------------------------- identifiers
;
; Everything below overrides these two. Capitalised identifiers name types and
; constructors, as in the reference implementation's own conventions.

(identifier) @variable

((identifier) @type
  (#match? @type "^_*[A-Z]"))

(escaped_identifier) @variable

; ---------------------------------------------------------------- comments

(comment) @comment
(difftest_output) @comment.doc

; `:flags` lines: consumed by the compiler's diff-test harness, not by the
; lexer, so they read as pragmas rather than as comments.
(difftest_directive) @preproc

; ---------------------------------------------------------------- literals

(integer_literal) @number
(decimal_literal) @number
(string_literal) @string
(escape_sequence) @string.escape
(boolean_literal) @boolean
(unit_literal) @constant.builtin

(this_expression) @variable.special
(super_expression) @variable.special
(wildcard) @variable.special

; ---------------------------------------------------------------- keywords

[
  "class"
  "trait"
  "module"
  "object"
  "mixin"
  "pattern"
  "type"
  "constructor"
  "new"
  "new!"
  "fun"
  "val"
  "using"
  "let"
  "set"
  "if"
  "while"
  "then"
  "else"
  "case"
  "do"
  "drop"
  "return"
  "throw"
  "yield"
  "yield*"
  "import"
  "open"
  "handle"
  "region"
  "try"
  "finally"
  "outer"
  "assert"
  "and"
  "or"
  "not"
  "is"
  "as"
  "of"
  "in"
  "extends"
  "restricts"
  "with"
  "where"
] @keyword

(modifier) @keyword

(annotation_name) @attribute

; ---------------------------------------------------------------- operators

(operator) @operator
(operator_identifier) @operator
(quoted_operator) @operator

[
  "="
  "=>"
  "->"
  "|"
  "&"
  ":"
  "#"
  "..."
  ".."
  "`"
  "`("
] @operator

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

"," @punctuation.delimiter

; ---------------------------------------------------------------- uses

(selection field: (identifier) @property)
(leading_selection field: (identifier) @property)
(member_projection member: (identifier) @property)
(pun name: (identifier) @property)

(application function: (identifier) @function)
(application function: (selection field: (identifier) @function))
(of_application function: (identifier) @function)

(new_expression constructor: (identifier) @constructor)
(new_expression constructor: (application function: (identifier) @constructor))
(new_expression constructor: (type_arguments function: (identifier) @constructor))

(directive name: (identifier) @preproc)
(directive name: (application function: (identifier) @preproc))

; ---------------------------------------------------------------- declarations
;
; A declaration head is an ordinary expression, so the name sits at the bottom
; of a left-nested spine: `Pair[A, B](x) extends Object with ...` is
; `infix_application(infix_application(application(type_arguments(Pair))))`.
; Every link keeps the name as its *first* named child, so the anchored
; wildcards below walk the spine without naming each combination.

(fun_definition
  head: [
    (identifier) @function
    (_ . (identifier) @function)
    (_ . (_ . (identifier) @function))
    (_ . (_ . (_ . (identifier) @function)))
    (_ . (_ . (_ . (_ . (identifier) @function))))
  ])

(val_definition
  head: [
    (identifier) @variable
    (_ . (identifier) @variable)
    (_ . (_ . (identifier) @variable))
    (_ . (_ . (_ . (identifier) @variable)))
  ])

; A `val` whose head is applied defines a function, not a value.
(val_definition head: (application function: (identifier) @function))
(val_definition head: (_ . (application function: (identifier) @function)))

(let_binding
  head: [
    (identifier) @variable
    (_ . (identifier) @variable)
    (_ . (_ . (identifier) @variable))
  ])

(set_binding
  head: [
    (identifier) @variable
    (_ . (identifier) @variable)
    (_ . (_ . (identifier) @variable))
  ])

(class_definition
  head: [
    (identifier) @type
    (_ . (identifier) @type)
    (_ . (_ . (identifier) @type))
    (_ . (_ . (_ . (identifier) @type)))
    (_ . (_ . (_ . (_ . (identifier) @type))))
  ])

(trait_definition
  head: [
    (identifier) @type
    (_ . (identifier) @type)
    (_ . (_ . (identifier) @type))
    (_ . (_ . (_ . (identifier) @type)))
  ])

(module_definition
  head: [
    (identifier) @type
    (_ . (identifier) @type)
    (_ . (_ . (identifier) @type))
    (_ . (_ . (_ . (identifier) @type)))
  ])

(object_definition
  head: [
    (identifier) @type
    (_ . (identifier) @type)
    (_ . (_ . (identifier) @type))
  ])

(mixin_definition
  head: [
    (identifier) @type
    (_ . (identifier) @type)
    (_ . (_ . (identifier) @type))
  ])

(type_definition
  head: [
    (identifier) @type
    (_ . (identifier) @type)
    (_ . (_ . (identifier) @type))
  ])

(pattern_definition
  head: [
    (identifier) @type
    (_ . (identifier) @type)
    (_ . (_ . (identifier) @type))
  ])

(handle_binding name: (identifier) @variable class: (identifier) @type)
(handle_in_binding name: (identifier) @variable class: (identifier) @type)
(region_expression name: (identifier) @variable)
(outer_expression name: (identifier) @variable)
(quoted_binding name: (identifier) @variable)

(open_statement module: (identifier) @type)
(import_statement path: (string_literal) @string.special)
