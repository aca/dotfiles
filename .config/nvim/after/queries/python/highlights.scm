; inherits: python
( (call
    function: (identifier) @function.builtin
    (#eq? @function.builtin "print")
) (#set! conceal "p") )
