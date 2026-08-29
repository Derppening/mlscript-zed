; MLscript opens a block by indentation, so the node to indent from is the one
; that *owns* the block: it starts on the header line, and it ends where the
; block ends. `block` itself starts on the first line of its own body, which is
; already indented, and Zed only indents a row whose predecessor is the start of
; an indent range.
;
; `block` is not part of `_expression`, so it is never a direct child of
; `source_file` or of another `block` -- every match here is a real header.
(_
  (block)) @indent

(_
  "("
  ")" @end) @indent

(_
  "["
  "]" @end) @indent

(_
  "{"
  "}" @end) @indent
