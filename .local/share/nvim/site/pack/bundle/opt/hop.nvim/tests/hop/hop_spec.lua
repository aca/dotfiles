local hop = require('hop')
local hop_helpers = require('hop_helpers')
local eq = assert.are.same

local override_keyseq = hop_helpers.override_keyseq

describe('hop commands:', function()
    before_each(function()
        vim.cmd.view('tests/tst_hop.txt')
        hop.setup()
        vim.api.nvim_win_set_cursor(0, { 1, 0 })
    end)

    it('HopChar, HopCharCL, HopCharAC, HopCharBC', function()
        override_keyseq({ 'h', 's' }, vim.cmd.HopChar)
        eq({ 3, 7 }, vim.api.nvim_win_get_cursor(0))
        override_keyseq({ 'h' }, vim.cmd.HopCharCL) -- config.auto_jump_one_target
        eq({ 3, 34 }, vim.api.nvim_win_get_cursor(0))
        override_keyseq({ 'o', 'd' }, vim.cmd.HopCharBC)
        eq({ 1, 14 }, vim.api.nvim_win_get_cursor(0))
        override_keyseq({ 'h', 's' }, vim.cmd.HopCharAC)
        eq({ 3, 7 }, vim.api.nvim_win_get_cursor(0))
    end)

    it('HopWord, HopWordCL', function()
        override_keyseq({ 'a' }, vim.cmd.HopWord)
        eq({ 3, 0 }, vim.api.nvim_win_get_cursor(0))
        override_keyseq({ 'a' }, vim.cmd.HopWordCL)
        eq({ 3, 27 }, vim.api.nvim_win_get_cursor(0))

        override_keyseq({ 'd' }, function()
            hop.word({ hint_position = 0.8 }) -- config.hint_position
        end)
        eq({ 1, 20 }, vim.api.nvim_win_get_cursor(0))
    end)

    it('HopAnywhere, HopAnywhereCL', function()
        local bs = hop.get_opts().key_delete
        override_keyseq({ 'j', bs, 'v' }, vim.cmd.HopAnywhere) -- config.key_delete
        eq({ 3, 0 }, vim.api.nvim_win_get_cursor(0))
        override_keyseq({ 'j', 'a' }, vim.cmd.HopAnywhereCL)
        eq({ 3, 27 }, vim.api.nvim_win_get_cursor(0))
    end)

    it('HopLineStart', function()
        vim.cmd.normal({ args = { 'w' }, bang = true })
        override_keyseq({ 'd' }, vim.cmd.HopLineStart)
        eq({ 3, 0 }, vim.api.nvim_win_get_cursor(0))
    end)

    it('HopVertical', function()
        vim.cmd.normal({ args = { 'w' }, bang = true })
        override_keyseq({ 's' }, vim.cmd.HopVertical)
        eq({ 3, 27 }, vim.api.nvim_win_get_cursor(0))

        vim.wo[0].virtualedit = 'all'
        override_keyseq({ 'a' }, vim.cmd.HopVertical)
        local curpos = vim.fn.getcurpos(0)
        eq(2, curpos[2])
        eq(1, curpos[3])
        eq(27, curpos[4])
    end)
end)
