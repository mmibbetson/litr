# `litr` Tangle

## Some Text

This is an example document! It shows how to tangle with litr. The syntax for litr is `:tangle <comment prefix> <output file path> <optional position>:`. The comment prefix is used for inserting untangling markers around the tangled block, allowing bi-directional editing and synchronisation. The position is used to determine the order the blocks will be tangled into the new file. If it is left out, the block will simply be tangled directly after the previous block in the source file.

```scm :tangle ;; out.scm 1:
(define say-hi
  (lambda (name) 
    (print-line (string "Hello, " name))))
```

If you load this function in the REPL and call it with your name, it'll say hello. If you tangle this file, you will create a file called `out.scm` with the following contents:

```scm
;; :untangle start litr-example.md 1:
(define say-hi
  (lambda (name) 
    (print-line (string "Hello, " name))))
;; :untangle end:

```

From this example you can see the untangle markers, as well as the newline inserted below each tangled block.

