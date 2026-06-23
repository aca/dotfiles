# tmux-remote

[![Tests](https://github.com/danyim/tmux-remote/actions/workflows/test.yml/badge.svg)](https://github.com/danyim/tmux-remote/actions/workflows/test.yml)

`tmux-remote` is a simple plugin that allows for toggling your tmux session's keybindings. This is especially useful when in nested remote tmux sessions that use the same prefix key as the host.

![](https://i.imgur.com/3gfFGpk.png)

Tested and working on macOS and Linux. Requires tmux 2.1+.

## Installation

#### Install with TPM
Install using [tpm](https://github.com/tmux-plugins/tpm) (tmux Plugin Manager)

By adding the following in your `.tmux.conf`:

```tmux
set -g @plugin 'danyim/tmux-remote'
```

Then hit `prefix + I` to fetch the plugin and source it.

#### Manual Install

Clone the repo:

    $ git clone https://github.com/danyim/tmux-remote

Add this line to the bottom of `.tmux.conf`:

```tmux
run-shell ~/path/to/tmux-remote/remote.tmux
```

Then reload your tmux environment with `$ tmux source-file ~/.tmux.conf`.

## Usage

After installing the plugin, simply press <kbd>F12</kbd> to toggle remote-mode on and off.

| Key             | Action                  |
| --------------  | ----------------------- |
| <kbd>F10</kbd>  | Turns on remote mode    |
| <kbd>F11</kbd>  | Turns off remote mode   |
| <kbd>F12</kbd>  | Toggles the remote mode |

### Options

#### Keybindings

```tmux
# Change the default on keybinding (F10)
set -g @remote-on-key F10
# Change the default off keybinding (F11)
set -g @remote-off-key F11
# Change the default toggle keybinding (F12)
set -g @remote-toggle-key F12
```

#### Indicator

When remote mode is active, a status-left indicator is shown. You can customize its text, foreground color, and background color:

```tmux
# Change the indicator text (default: " REMOTE >>>  ")
set -g @remote-indicator-text " REMOTE >>>  "
# Change the indicator foreground color (default: colour228)
set -g @remote-indicator-fg "colour228"
# Change the indicator background color (default: colour52)
set -g @remote-indicator-bg "colour52"
```

## Testing
Tests run automatically via [GitHub Actions](https://github.com/danyim/tmux-remote/actions/workflows/test.yml) on push and PR.

## Resources

- [Tmux in practice: local and nested remote tmux sessions](https://medium.freecodecamp.org/tmux-in-practice-local-and-nested-remote-tmux-sessions-4f7ba5db8795)
  Medium article by Alexey Samoshkin that inspired this plugin
- [Nested tmux](http://stahlke.org/dan/tmux-nested/)
  article by Dan Stahlke outlining the method for toggling keybindings

## License

[MIT](LICENSE.md)
