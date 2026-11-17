; First source-block parameter is the language; later ones are header arguments.
(block
  name: (expr) @_block_name
  . parameter: (expr) @injection.language
  contents: (contents) @injection.content
  (#match? @_block_name "^[sS][rR][cC]$"))
