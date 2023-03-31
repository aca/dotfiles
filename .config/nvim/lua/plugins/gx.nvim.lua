vim.cmd.packadd("gx.nvim")

-- https://github.com/chrishrb/gx.nvim

require("gx").setup {
    -- open_browser_app = "os_specific", -- specify your browser app; default for macos is "open" and for linux "xdg-open"
    handlers = {
        plugin = false, -- open plugin links in lua (e.g. packer, lazy, ..)
        github = true, -- open github issues
        package_json = false, -- open dependencies from package.json
    }
}
