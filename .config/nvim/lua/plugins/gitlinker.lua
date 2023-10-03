local vim = vim

vim.cmd.packadd("plenary.nvim")
vim.cmd.packadd("gitlinker.nvim")

vim.api.nvim_create_user_command("GBrowse", function()
    require("gitlinker").link({action = require("gitlinker.actions").clipboard})
    require("gitlinker").link({action = require("gitlinker.actions").system})
end, {
    range = true,
})

vim.api.nvim_create_user_command("Gbrowse", function()
    require("gitlinker").link({action = require("gitlinker.actions").clipboard})
    require("gitlinker").link({action = require("gitlinker.actions").system})
end, {
    range = true,
})

-- vim.keymap.set(
--     { 'n', 'x' },
--     '<leader>go',
--     '<cmd>lua require("gitlinker").link({action = require("gitlinker.actions").clipboard})<cr>',
--     { desc = "Copy git link to clipboard" }
-- )

vim.keymap.set(
    { 'n', 'x' },
    '<leader>gb',
    function()
        require("gitlinker").link({action = require("gitlinker.actions").system})
    end,
    { desc = "Copy git link to clipboard" }
)

require('gitlinker').setup({
  mapping = {
    ["<leader>go"] = {
      action = require("gitlinker.actions").clipboard,
      desc = "Copy git link to clipboard",
    },
    ["<leader>xg"] = {
      action = require("gitlinker.actions").system,
      desc = "Open git link in default browser",
    },
  },

})
--
-- -- require("gitlinker").setup({
-- -- 	opts = {
-- -- 		remote = nil,
-- -- 		add_current_line_on_normal_mode = true,
-- -- 		print_url = false,
-- -- 		silent = true,
-- --
-- -- 		action_callback = function(url)
-- -- 			-- yank to unnamed register
-- -- 			-- vim.api.nvim_command("let @\" = '" .. url .. "'")
-- -- 			-- copy to the system clipboard using OSC52
-- -- 			-- vim.fn.OSCYankString(url)
-- --             -- require('osc52').copy(url)
-- -- 			require("gitlinker.actions").open_in_browser(url)
-- -- 		end,
-- -- 	},
-- -- 	callbacks = {
-- --         ["github.com"] = require"gitlinker.hosts".get_github_type_url,
-- --         ["gitlab.com"] = require"gitlinker.hosts".get_gitlab_type_url,
-- --         ["try.gitea.io"] = require"gitlinker.hosts".get_gitea_type_url,
-- --         ["codeberg.org"] = require"gitlinker.hosts".get_gitea_type_url,
-- --         ["bitbucket.org"] = require"gitlinker.hosts".get_bitbucket_type_url,
-- --         ["try.gogs.io"] = require"gitlinker.hosts".get_gogs_type_url,
-- --         ["git.sr.ht"] = require"gitlinker.hosts".get_srht_type_url,
-- --         ["git.launchpad.net"] = require"gitlinker.hosts".get_launchpad_type_url,
-- --         ["repo.or.cz"] = require"gitlinker.hosts".get_repoorcz_type_url,
-- --         ["git.kernel.org"] = require"gitlinker.hosts".get_cgit_type_url,
-- --         ["git.savannah.gnu.org"] = require"gitlinker.hosts".get_cgit_type_url
-- -- 	},
-- --
-- -- 	-- mappings = "<leader>gl",
-- -- })
--
-- -- -- NOTES: range doesn't work
