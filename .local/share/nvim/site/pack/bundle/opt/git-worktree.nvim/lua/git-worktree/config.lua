---@mod git-worktree.config plugin configuration
---
---@brief [[
---
--- git-worktree.nvim does not need a `setup` function to work.
---
---To configure git-worktree.nvim, set the variable `vim.g.git-worktree`,
---which is a `GitWorktreeConfig` table, in your neovim configuration.
---

--- The plugin configuration.
--- Merges the default config with `vim.g.git_worktree`.
---
---Example:
---
--->lua
------@type GitWorktreeConfig
---vim.g.git_worktree = {
---    change_directory_command = 'cd',
---    update_on_change = true,
---    update_on_change_command = 'e .',
---    clearjumps_on_change = true,
---    confirm_telescope_deletions = true,
---    autopush = false,
--- }
---<
---

---@brief ]]

---@class GitWorktreeConfig
---@field change_directory_command string command to change directory on your OS
---@field update_on_change_command string vim command to call to switch file buffer to new git-worktree
---@field clearjumps_on_change boolean clear jump list on change
---@field confirm_telescope_deletions boolean confirm telescope deletions operations
---@field autopush boolean automatically push worktree to origin repo

---@type (fun():GitWorktreeConfig) | GitWorktreeConfig | nil
vim.g.git_worktree = vim.g.git_worktree

local GitWorktreeDefaultConfig = {

    -- command to change directory on your OS.
    --- @type string
    change_directory_command = 'cd',

    -- vim command to call to switch file buffer to new git-worktree
    --- @type string
    update_on_change_command = 'e .',

    -- clear jump list on change
    --- @type boolean
    clearjumps_on_change = true,

    -- confirm telescope deletions operations
    --- @type boolean
    confirm_telescope_deletions = true,

    -- automatically push worktree to origin repo
    --- @type boolean
    autopush = false,
}

local git_worktree = vim.g.git_worktree or {}
---@type GitWorktreeConfig
local opts = type(git_worktree) == 'function' and git_worktree() or git_worktree

local GitWorktreeConfig = vim.tbl_deep_extend('force', {}, GitWorktreeDefaultConfig, opts)

return GitWorktreeConfig
