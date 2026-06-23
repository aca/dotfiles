# vim-goaddtags

`:GoAddTags` command for Go

## Usage

When you have struct

```go
type Foo struct {
     Name  string
     Value int
}
```

Add json/db tags to the struct under the cursor

```
:GoAddTags json db
```

```go
type Foo struct {
    Name string `json:"name" db:"name"`
    Age  int    `json:"age" db:"age"`
}

```

If you prefer to use `camelCase` instead of `snake_case` for the values, you can use the `g:go_addtags_transform` variable to define a different transformation rule. The following example uses the `camelCase` transformation rule.

```vim
let g:go_addtags_transform = 'camelcase'
```

## Installation


For [vim-plug](https://github.com/junegunn/vim-plug) plugin manager:

```viml
Plug 'mattn/vim-goaddtags'
```

## License

MIT

## Author

Yasuhiro Matsumoto (a.k.a. mattn)
