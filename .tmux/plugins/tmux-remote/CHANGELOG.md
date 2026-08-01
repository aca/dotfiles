# Changelog

### v0.1.1, 2026-06-16
- fix: calling toggle_off before toggle_on (or after server restart) no longer blanks status-left
- fix: clear saved status-left state after each toggle-off so re-toggling captures the current value
- fix: suppress spurious stderr from tmux show-option on unset options during plugin init and first toggle
- fix: split `local` declarations from command substitution assignments to preserve tmux exit codes
- fix: suppress expected "key not found" errors from unbind calls on fresh plugin load
- fix: broken shebang in test_default_options.sh (was missing `!` and indented); quote `$CURRENT_DIR` in source
- refactor: toggle_on.sh and toggle_off.sh now source variables.sh and use named
  variables for all option keys rather than hardcoded strings, so renames stay in sync

### v0.1.0, 2018-05-20
- initial work on the plugin
- add readme
