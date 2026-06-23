local hop = require('hop')
local hop_helpers = require('hop_helpers')
local eq = assert.are.same

local override_keyseq = hop_helpers.override_keyseq

describe('config.match_mappings:', function()
    before_each(function()
        vim.cmd.view('tests/tst_mappings_zh.txt')
        hop.setup({ match_mappings = { 'zh', 'zh_sc', 'zh_tc' } })
    end)

    describe('hop.char,', function()
        before_each(function()
            vim.api.nvim_win_set_cursor(0, { 1, 0 })
        end)

        it('zh', function()
            override_keyseq({ ',' }, hop.char)
            eq({ 2, 58 }, vim.api.nvim_win_get_cursor(0))
        end)

        it('zh_sc', function()
            override_keyseq({ 'f', 's' }, hop.char)
            eq({ 2, 72 }, vim.api.nvim_win_get_cursor(0))
        end)

        it('zh_tc', function()
            override_keyseq({ 'f', 'a' }, hop.char)
            eq({ 3, 52 }, vim.api.nvim_win_get_cursor(0))
        end)
    end)

    it('hop.vertical', function()
        vim.o.wrap = false
        vim.wo[0].virtualedit = 'none'
        vim.api.nvim_win_set_cursor(0, { 1, 65 })
        local col = vim.fn.wincol()

        override_keyseq({ 'a' }, hop.vertical)
        eq({ 2, 72 }, vim.api.nvim_win_get_cursor(0))
        eq(col, vim.fn.wincol())

        vim.cmd.normal({ args = { '16zl' }, bang = true })
        -- It's seemd a neovim's bug.
        -- I have to move right then left back here, to guarantee the next cursor is {3, 72}.
        -- Or the next cursor will be still {2, 72}.
        vim.cmd.normal({ args = { 'lh' }, bang = true })
        col = col - 16

        override_keyseq({ 'a' }, hop.vertical)
        eq({ 3, 72 }, vim.api.nvim_win_get_cursor(0))
        eq(col, vim.fn.wincol())
    end)
end)
