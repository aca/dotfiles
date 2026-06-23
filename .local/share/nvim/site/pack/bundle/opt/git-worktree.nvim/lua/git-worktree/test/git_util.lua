local system = require('git-worktree.test.system_util')

-- local change_dir = function(dir)
--     vim.api.nvim_set_current_dir(dir)
-- end

local create_worktree = function(folder_path, commitish)
    system.run('git worktree add ' .. folder_path .. ' ' .. commitish)
end

local M = {}

local origin_repo_path = nil

function M.setup_origin_repo()
    if origin_repo_path ~= nil then
        return origin_repo_path
    end

    local workspace_dir = system.create_temp_dir('workspace-dir')
    vim.api.nvim_set_current_dir(vim.fn.getcwd())
    system.run('cp -r test/fixtures/.repo ' .. workspace_dir)
    vim.api.nvim_set_current_dir(workspace_dir)
    system.run([[
        mv .repo/.git-orig ./.git
        mv .repo/* .
        git config user.email "test@test.test"
        git config user.name "Test User"
    ]])

    origin_repo_path = system.create_temp_dir('origin-repo')
    system.run(string.format('git clone --bare %s %s', workspace_dir, origin_repo_path))

    return origin_repo_path
end

function M.prepare_repo()
    M.setup_origin_repo()

    local working_dir = system.create_temp_dir('working-dir')
    local master_dir = working_dir .. '/master'
    vim.api.nvim_set_current_dir(working_dir)
    system.run(string.format('git clone %s %s', origin_repo_path, master_dir))
    vim.api.nvim_set_current_dir(master_dir)
    system.run([[
        git config remote.origin.url git@github.com:test/test.git
        git config user.email "test@test.test"
        git config user.name "Test User"
    ]])
    return working_dir, master_dir
end

function M.prepare_repo_bare()
    M.setup_origin_repo()

    local working_dir = system.create_temp_dir('working-bare-dir')
    vim.api.nvim_set_current_dir(working_dir)
    system.run(string.format('git clone --bare %s %s', origin_repo_path, working_dir))
    return working_dir
end

--- @param num_worktrees integer
function M.prepare_repo_bare_worktree(num_worktrees)
    local working_dir = M.prepare_repo_bare()
    local master_dir = working_dir .. '/master'

    if num_worktrees > 0 then
        create_worktree('master', 'master')
    end

    if num_worktrees > 1 then
        create_worktree('featB', 'featB')
    end

    if num_worktrees > 2 then
        create_worktree('featC', 'featC')
    end

    vim.api.nvim_set_current_dir(master_dir)

    return working_dir, master_dir
end

--- @param num_worktrees integer
function M.prepare_repo_normal_worktree(num_worktrees)
    local working_dir, master_dir = M.prepare_repo()

    if num_worktrees > 0 then
        create_worktree('../featB', 'featB')
    end

    if num_worktrees > 1 then
        create_worktree('../featC', 'featC')
    end

    return working_dir, master_dir
end

return M
