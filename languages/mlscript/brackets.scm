("(" @open
  ")" @close)

("[" @open
  "]" @close)

("{" @open
  "}" @close)

; `` f`(x) `` -- the quasiquote application bracket closes with a plain `)`.
("`(" @open
  ")" @close)
