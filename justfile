exe := "/home/gtrun/ghq/github.com/BrianHicks/tree-grepper/target/debug/tree-grepper --query nix"

test:
    {{exe}} '((identifier) @variable.builtin (#match? @variable.builtin "^(__currentSystem|__currentTime|__nixPath|__nixVersion|__storeDir|builtins|false|null|true)$") (#is-not? local))'


test1:
    {{exe}} '[ (path_expression) (hpath_expression) (spath_expression)] @string.special.path'

test2:
    {{exe}} "(formal name: (identifier) @variable.parameter "?"? @punctuation.delimiter)"

test3:
    {{exe}} "[ (string_expression) (indented_string_expression) ] @string"

test4:
    {{exe}} "(binding attrpath: (attrpath (identifier)) @property)"
