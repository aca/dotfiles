local git_harness = require('git-worktree.test.git_util')
local gwt_git = require('git-worktree.git')

-- local wait_for_result = function(job, result)
--     if type(result) == 'string' then
--         result = { result }
--     end
--     vim.wait(1000, function()
--         return tables_equal(job:result(), result)
--     end)
-- end

local cwd = vim.fn.getcwd()

-- luacheck: globals working_dir master_dir
describe('git-worktree git operations', function()
    describe('in normal repo', function()
        before_each(function()
            working_dir, master_dir = git_harness.prepare_repo()
        end)
        after_each(function()
            vim.api.nvim_command('cd ' .. cwd)
        end)
        it('finds toplevel.', function()
            local ret = gwt_git.toplevel_dir()
            assert.are.same(ret, master_dir)
        end)
        it('finds root git dir.', function()
            local ret = gwt_git.gitroot_dir()
            local root_repo_dir = master_dir .. '/.git'
            assert.are.same(ret, root_repo_dir)
        end)
        it('has_worktree valid absolute.', function()
            local completed = false
            local ret = false

            gwt_git.has_worktree(master_dir, nil, function(found)
                completed = true
                ret = found
            end)

            vim.fn.wait(10000, function()
                return completed
            end, 1000)

            assert.are.same(true, ret)
        end)
        it('has_worktree valid relative.', function()
            local completed = false
            local ret = false

            gwt_git.has_worktree('.', nil, function(found)
                completed = true
                ret = found
            end)

            vim.fn.wait(10000, function()
                return completed
            end, 1000)

            assert.are.same(true, ret)
        end)
        it('has_worktree invalid absolute.', function()
            local completed = false
            local ret = false

            gwt_git.has_worktree('/tmp', nil, function(found)
                completed = true
                ret = found
            end)

            vim.fn.wait(10000, function()
                return completed
            end, 1000)

            assert.are.same(false, ret)
        end)
        it('has_worktree invalid relative.', function()
            local completed = false
            local ret = false

            gwt_git.has_worktree('../foo', nil, function(found)
                completed = true
                ret = found
            end)

            vim.fn.wait(10000, function()
                return completed
            end, 1000)

            assert.are.same(false, ret)
        end)
    end)

    describe('in bare repo', function()
        before_each(function()
            working_dir = git_harness.prepare_repo_bare()
        end)
        after_each(function()
            vim.api.nvim_command('cd ' .. cwd)
        end)
        it('finds toplevel', function()
            local ret = gwt_git.toplevel_dir()
            assert.are.same(ret, nil)
        end)
        it('finds root git dir.', function()
            local ret_git_dir = gwt_git.gitroot_dir()
            assert.are.same(ret_git_dir, working_dir)
        end)
        it('has_worktree valid absolute.', function()
            local completed = false
            local ret = false

            gwt_git.has_worktree(working_dir, nil, function(found)
                completed = true
                ret = found
            end)

            vim.fn.wait(10000, function()
                return completed
            end, 1000)

            assert.are.same(true, ret)
        end)
        it('has_worktree valid relative.', function()
            local completed = false
            local ret = false

            gwt_git.has_worktree('.', nil, function(found)
                completed = true
                ret = found
            end)

            vim.fn.wait(10000, function()
                return completed
            end, 1000)

            assert.are.same(true, ret)
        end)
        it('has_worktree invalid absolute.', function()
            local completed = false
            local ret = false

            gwt_git.has_worktree('/tmp', nil, function(found)
                completed = true
                ret = found
            end)

            vim.fn.wait(10000, function()
                return completed
            end, 1000)

            assert.are.same(false, ret)
        end)
        it('has_worktree invalid relative.', function()
            local completed = false
            local ret = false

            gwt_git.has_worktree('../foo', nil, function(found)
                completed = true
                ret = found
            end)

            vim.fn.wait(10000, function()
                return completed
            end, 1000)

            assert.are.same(false, ret)
        end)
    end)

    describe('in worktree repo', function()
        before_each(function()
            working_dir, master_dir = git_harness.prepare_repo_bare_worktree(1)
        end)
        after_each(function()
            vim.api.nvim_command('cd ' .. cwd)
        end)
        it('finds toplevel.', function()
            local ret = gwt_git.toplevel_dir()
            assert.are.same(ret, master_dir)
        end)
        it('finds root git dir.', function()
            local ret = gwt_git.gitroot_dir()
            assert.are.same(ret, working_dir)
        end)
    end)
end)
