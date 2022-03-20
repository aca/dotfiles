-- DEBUG [[
-- vim.lsp.set_log_level("debug")
-- require("vim.lsp.log").set_format_func(vim.inspect)
-- ]]

-- UPDATE [[
-- :TSInstall all
-- :TSUpdate all
-- :LspUpdateAll
-- ]]

-- TODO: jupyter integration
-- https://www.reddit.com/r/neovim/comments/p206ju/magmanvim_interact_with_jupyter_from_neovim/
-- https://github.com/dccsillag/magma-nvim

-- TODO: zettels related
-- require 'zettels'

local vim = vim
local g = vim.g
local cmd = vim.cmd

-- https://github.com/lewis6991/impatient.nvim
require("impatient")
-- require("impatient").enable_profile()

require("globals")
require("vim")
require("plugins.treesitter")
vim.loop.new_timer():start(
    0,
    0,
    vim.schedule_wrap(function()
        require("plugins.autopairs")
        require("plugins.luasnip")
        require("plugins.lsp")
        require("plugins.cmp")
        -- require("plugins.dap")

        cmd([[
      runtime! autoload/plugin/*
      runtime! autoload/func/*
      runtime! autoload/autocmd/*
      runtime! autoload/command/*
      runtime! autoload/map/*
      runtime! autoload/lib/*
      runtime! autoload/local/*
      " helptags ALL
      ]])
    end)

)


-- vim.cmd [[ packadd lualine.nvim ]]
-- -- -- Inspired Github Colors
-- local colors = {
--   red = '#ca1243',
--   grey = '#f5f5f5',
--   light_grey = '#979BAC',
--   black = '#383a42',
--   white = '#ffffff',
--   transparent = '#ffffff',
--   light_green = '#83a598',
--   orange = '#fe8019',
--   green = '#8ec07c',
--   yellow = '#f8eec7',
--   cyan = '#489FC1',
-- }
--
-- local inspired_github = {
--   normal = {
--     a = { fg = colors.white, bg = colors.red },
--     b = { fg = colors.black,  bg = colors.grey },
--     c = { fg = colors.light_grey, bg = colors.white },
--     z = { fg = colors.white, bg = colors.black },
--   },
--   insert = { a = { fg = colors.black, bg = colors.yellow } },
--   visual = { a = { fg = colors.white, bg = colors.cyan } },
--   replace = { a = { fg = colors.black, bg = colors.green } },
-- }
--
-- local empty = require('lualine.component'):extend()
-- function empty:draw(default_highlight)
--   self.status = ''
--   self.applied_separator = ''
--   self:apply_highlights(default_highlight)
--   self:apply_section_separators()
--   return self.status
-- end
--
-- -- Put proper separators and gaps between components in sections
-- local function process_sections(sections)
--   for name, section in pairs(sections) do
--     local left = name:sub(9, 10) < 'x'
--     for pos = 1, name ~= 'lualine_z' and #section or #section - 1 do
--       table.insert(section, pos * 2, { empty, color = { fg = colors.white, bg = colors.transparent } })
--     end
--     for id, comp in ipairs(section) do
--       if type(comp) ~= 'table' then
--         comp = { comp }
--         section[id] = comp
--       end
--       comp.separator = left and { right = '' } or { left = '' }
--     -- if you're using iTerm with a text line height more than 100, use the separators below instead
--       -- comp.separator = left and { right = '' } or { left = '' }
--     end
--   end
--   return sections
-- end
--
-- local function search_result()
--   if vim.v.hlsearch == 0 then
--     return ''
--   end
--   local last_search = vim.fn.getreg('/')
--   if not last_search or last_search == '' then
--     return ''
--   end
--   local searchcount = vim.fn.searchcount { maxcount = 9999 }
--   return last_search .. '(' .. searchcount.current .. '/' .. searchcount.total .. ')'
-- end
--
-- local function modified()
--   if vim.bo.modified then
--     return '+'
--   elseif vim.bo.modifiable == false or vim.bo.readonly == true then
--     return '-'
--   end
--   return ''
-- end
--
-- require('lualine').setup {
--   options = {
--     theme = inspired_github,
--     component_separators = '',
--     section_separators = { left = '', right = '' },
--     -- if you're using iTerm with a text line height more than 100, use the separators below instead
--     -- section_separators = { left = '', right = ''},
--   },
--   -- process_sections
--   sections = process_sections {
--     lualine_a = { 'mode' },
--     lualine_b = {
--       'branch',  
--       { 'filename', file_status = false, path = 3 },
--       {
--         'diagnostics',
--         source = { 'intelephense' },
--         sections = { 'error' },
--         diagnostics_color = { error = { bg = colors.red, fg = colors.white } },
--       },
--       {
--         'diagnostics',
--         source = { 'intelephense' },
--         sections = { 'warn' },
--         diagnostics_color = { warn = { bg = colors.orange, fg = colors.white } },
--       },
--       {
--         'diagnostics',
--         source = { 'intelephense' },
--         sections = { 'hint' },
--         diagnostics_color = { warn = { bg = colors.orange, fg = colors.white } },
--       },
--       { modified, color = { bg = colors.yellow } },
--     },
--     lualine_c = {},
--     lualine_x = {},
--     lualine_y = { search_result, 'filetype' },
--     lualine_z = { '%l:%c', '%p%%/%L' },
--   },
--   inactive_sections = {
--     lualine_c = { '%f %y %m' },
--     lualine_x = {},
--   },
-- }
