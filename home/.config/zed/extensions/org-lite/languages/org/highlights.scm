; Structural highlighting; use capture names supported by Zed themes.
(headline (stars) @punctuation.special (item) @title)
(tag_list (tag) @tag)

(headline (item . (expr) @keyword
  (#any-of? @keyword "TODO" "NEXT" "WAIT" "WAITING" "HOLD")))
(headline (item . (expr) @constant
  (#any-of? @constant "DONE" "CANCELLED" "CANCELED")))

(comment) @comment
(directive "#+" @punctuation.special name: (expr) @keyword)
(property_drawer) @text.literal
(property name: (expr) @property value: (value)? @string)
(drawer name: (expr) @label)
(entry name: (entry_name) @keyword)
(timestamp) @number

(block name: (expr) @keyword end_name: (expr) @keyword)
(block contents: (contents) @text.literal)
(dynamic_block) @text.literal
(bullet) @punctuation.list_marker
(checkbox) @punctuation.bracket
(checkbox status: (expr) @constant
  (#any-of? @constant "x" "X"))
(hr) @punctuation.delimiter
(fndef label: (expr) @label)
