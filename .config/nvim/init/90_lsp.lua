vim.cmd.packadd("nvim-navic")

local navic = require("nvim-navic")
-- navic.setup {
--     icons = {
--         File          = " ",
--         Module        = " ",
--         Namespace     = " ",
--         Package       = " ",
--         Class         = " ",
--         Method        = " ",
--         Property      = " ",
--         Field         = " ",
--         Constructor   = " ",
--         Enum          = " ",
--         Interface     = " ",
--         Function      = " ",
--         Variable      = " ",
--         Constant      = " ",
--         String        = " ",
--         Number        = " ",
--         Boolean       = " ",
--         Array         = " ",
--         Object        = " ",
--         Key           = " ",
--         Null          = " ",
--         EnumMember    = " ",
--         Struct        = " ",
--         Event         = " ",
--         Operator      = " ",
--         TypeParameter = " ",
--     },
--     lsp = {
--         auto_attach = false,
--         preference = nil,
--     },
--     highlight = false,
--     separator = " > ",
--     depth_limit = 0,
--     depth_limit_indicator = "..",
--     safe_output = true,
--     lazy_update_context = false,
--     click = false,
--     format_text = function(text)
--         return text
--     end,
-- }

local function setup_winbar(client, bufnr)
  -- local status_ok, method_supported = pcall(function()
  --   return client.supports_method 'textDocument/documentSymbol'
  -- end)

  -- if not status_ok or not method_supported then
  --   return
  -- end
  -- navic.attach(client, bufnr)

  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('_navic', {}),
  callback = function(ctx)
    -- BUG:not null-ls, may be packer or neovim upstream
    if not ctx.data then
      return
    end
    local client = vim.lsp.get_client_by_id(ctx.data.client_id)
    local bufnr = ctx.buf
    setup_winbar(client, bufnr)
  end,
})


vim.cmd.packadd("nvim-lspconfig")
-- vim.lsp.bashls.cmd = { "bash-language-server", "start" }

vim.lsp.enable({ "gopls", "lua_ls", "basedpyright", "vtsls", "teal_ls", "ols", "zls", "bashls", "clangd" })
