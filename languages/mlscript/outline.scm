; A declaration head is an ordinary expression, so the name sits at the bottom
; of a left-nested spine: `Pair[A, B](x) extends Object with ...` is
; `infix_application(infix_application(application(type_arguments(Pair))))`.
; Every link in that spine keeps the name as its *first* named child, so the
; anchored wildcards below walk it without naming each combination.

(annotation) @annotation

(fun_definition
  (modifier)* @context
  "fun" @context
  head: [
    (identifier) @name
    (_ . (identifier) @name)
    (_ . (_ . (identifier) @name))
    (_ . (_ . (_ . (identifier) @name)))
    (_ . (_ . (_ . (_ . (identifier) @name))))
  ]) @item

(val_definition
  (modifier)* @context
  ["val" "using"] @context
  head: [
    (identifier) @name
    (_ . (identifier) @name)
    (_ . (_ . (identifier) @name))
    (_ . (_ . (_ . (identifier) @name)))
  ]) @item

(class_definition
  (modifier)* @context
  "class" @context
  head: [
    (identifier) @name
    (_ . (identifier) @name)
    (_ . (_ . (identifier) @name))
    (_ . (_ . (_ . (identifier) @name)))
    (_ . (_ . (_ . (_ . (identifier) @name))))
  ]) @item

(trait_definition
  (modifier)* @context
  "trait" @context
  head: [
    (identifier) @name
    (_ . (identifier) @name)
    (_ . (_ . (identifier) @name))
    (_ . (_ . (_ . (identifier) @name)))
  ]) @item

(module_definition
  (modifier)* @context
  "module" @context
  head: [
    (identifier) @name
    (_ . (identifier) @name)
    (_ . (_ . (identifier) @name))
    (_ . (_ . (_ . (identifier) @name)))
  ]) @item

(object_definition
  (modifier)* @context
  "object" @context
  head: [
    (identifier) @name
    (_ . (identifier) @name)
    (_ . (_ . (identifier) @name))
  ]) @item

(mixin_definition
  (modifier)* @context
  "mixin" @context
  head: [
    (identifier) @name
    (_ . (identifier) @name)
    (_ . (_ . (identifier) @name))
  ]) @item

(type_definition
  (modifier)* @context
  "type" @context
  head: [
    (identifier) @name
    (_ . (identifier) @name)
    (_ . (_ . (identifier) @name))
  ]) @item

(pattern_definition
  (modifier)* @context
  "pattern" @context
  head: [
    (identifier) @name
    (_ . (identifier) @name)
    (_ . (_ . (identifier) @name))
  ]) @item
