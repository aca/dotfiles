# auto-cmdheight.nvim

This plugin dynamically resizes your `'cmdheight'` to fit the content of
messages displayed via `vim.api.nvim_echo()`, `vim.print()`, and `print()`.
This removes the "Hit Enter" prompt for many cases.

https://github.com/user-attachments/assets/6fda7f6a-0244-4192-83de-ebec8aa8fb92

### Setup (lazy.nvim)

```lua
{
  "jake-stewart/auto-cmdheight.nvim",
  lazy = false,
  opts = {
    -- max cmdheight before displaying hit enter prompt.
    max_lines = 5,

    -- number of seconds until the cmdheight can restore.
    duration = 2,

    -- whether key press is required to restore cmdheight.
    remove_on_key = true,

    -- always clear the cmdline after duration and key press.
    -- by default it will only happen when cmdheight changed.
    clear_always = false,
  }
}
```

