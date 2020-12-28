" prevent auto close when next character is non whitespace
call lexima#add_rule({'at': '\%#\w', 'char': '(', 'input': '('})
