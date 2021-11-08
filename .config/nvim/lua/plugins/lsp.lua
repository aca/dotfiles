local lspconfig = require("lspconfig")
local util = require("lspconfig/util")
local configs = require("lspconfig/configs")

-- Based on https://github.com/hrsh7th/cmp-nvim-lsp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- capabilities.textDocument.completion.completionItem.documentationFormat = {"markdown"}
-- capabilities.textDocument.completion.completionItem.preselectSupport = false
-- capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
-- capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
-- capabilities.textDocument.completion.completionItem.deprecatedSupport = true
-- capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
-- capabilities.textDocument.completion.completionItem.tagSupport = {valueSet = {1}}
-- capabilities.textDocument.completion.completionItem.resolveSupport = {
--     properties = {
--         "documentation",
--         "detail",
--         "additionalTextEdits"
--     }
-- }

-- TODO: slow diagnostic update on mac
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
-- 	virtual_text = true,
-- 	signs = true,
-- 	underline = true,
-- 	update_in_insert = true,
-- })

lspconfig.tsserver.setup({ capabilities = capabilities }) -- Need typescript installed to use for javascript project
lspconfig.emmet_ls.setup({
  capabilities = capabilities,
  cmd = { "emmet-ls", "--stdio"},
  -- cmd = { "emmetls.sh"},
})

lspconfig.gopls.setup({ capabilities = capabilities })

lspconfig.gopls.setup {
  capabilities = capabilities ,
  settings = {
    gopls = {
      analyses = {
        unusedparams = false,
      },
      staticcheck = true,
    },
  },
}


-- lspconfig.hls.setup {capabilities = capabilities}
-- lspconfig.racket_langserver.setup{ capabilities = capabilities; }
-- lspconfig.bashls.setup {capabilities = capabilities}
-- lspconfig.vimls.setup { capabilities = capabilities; }
-- lspconfig.cssls.setup{ capabilities = capabilities; }
-- lspconfig.dockerls.setup{ capabilities = capabilities; }
-- lspconfig.html.setup{ capabilities = capabilities; }
-- lspconfig.jsonls.setup {capabilities = capabilities}
lspconfig.yamlls.setup {capabilities = capabilities}
lspconfig.rust_analyzer.setup({ capabilities = capabilities })
lspconfig.clangd.setup({ capabilities = capabilities })
-- lspconfig.terraformls.setup {capabilities = capabilities}

-- https://www.reddit.com/r/neovim/comments/mrep3l/speedup_your_prettier_formatting_using_prettierd/
-- lspconfig.denols.setup({
-- 	-- filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" , "json"},
-- 	-- filetypes = { "json", "yaml", "markdown"},
-- 	filetypes = { "json", "yaml" },
-- 	root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git", vim.fn.getcwd()),
-- 	settings = {
-- 		init_options = {
-- 			enable = true,
-- 			lint = true,
-- 			unstable = false,
-- 		},
-- 	},
-- })

-- local luadev =
--     require("lua-dev").setup(
--     {
--         lspconfig = {
--             cmd = require'lspcontainers'.command('sumneko_lua'),
--             capabilities = capabilities
--         }
--     }
-- )
--
-- lspconfig.sumneko_lua.setup(luadev)

-- if vim.fn.executable("docker") == 1 then
--   local runtime_path = vim.split(package.path, ";")
--   table.insert(runtime_path, "lua/?.lua")
--   table.insert(runtime_path, "lua/?/init.lua")
--   lspconfig.sumneko_lua.setup({
--     cmd = {"lua-language-server"},
--     -- cmd = require("lspcontainers").command("sumneko_lua"),
--     settings = {
--       capabilities = capabilities,
--       Lua = {
--         runtime = {
--           -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--           version = "LuaJIT",
--           -- Setup your lua path
--           path = runtime_path,
--         },
--         diagnostics = {
--           -- Get the language server to recognize the `vim` global
--           globals = { "vim" },
--         },
--         workspace = {
--           -- Make the server aware of Neovim runtime files
--           library = vim.api.nvim_get_runtime_file("", true),
--         },
--         -- Do not send telemetry data containing a randomized but unique identifier
--         telemetry = {
--           enable = false,
--         },
--       },
--     },
--   })
-- end

--[[

Custom lang servers

--]]

require("pylance")
lspconfig.pylance.setup({
	capabilities = capabilities,
	settings = {
		python = {
			analysis = {},
		},
	},
})

-- configs.korean_ls = {
-- default_config = {
--     cmd = {"korean-ls", "--stdio"},
--     filetypes = {"text"},
--     root_dir = function()
--         return vim.loop.cwd()
--     end,
--     settings = {}
-- }
-- }
-- lspconfig.korean_ls.setup {}

-- if os.getenv("LS_KOREAN") == "on" then
--     configs.korean_ls = {
--         default_config = {
--             cmd = {"korean-ls", "--stdio"},
--             filetypes = {"text"},
--             root_dir = function()
--                 return vim.loop.cwd()
--             end,
--             settings = {}
--         }
--     }
--     lspconfig.korean_ls.setup {}
-- end

-- neuron language server
-- nvim_lsp.configs.neuron_ls = {
-- default_config = {
--     -- cmd = {'neuron', 'lsp'};
--     cmd = {'neuron-language-server'};
--     filetypes = {'markdown'};
--     root_dir = function()
--       return vim.loop.cwd()
--     end;
--     settings = {};
--   };
-- }
-- nvim_lsp.neuron_ls.setup{}

-- if not lspconfig.emmet_ls then
--   configs.emmet_ls = {
--     default_config = {
--       cmd = {'emmet-ls', '--stdio'};
--       filetypes = {'html', 'css'};
--       root_dir = function(fname)
--         return vim.loop.cwd()
--       end;
--       settings = {};
--     };
--   }
-- end


-- configs.zk = {
--   default_config = {
--     cmd = {'zk', 'lsp'},
--     filetypes = {'markdown'},
--     root_dir = function()
--       return vim.loop.cwd()
--     end,
--     settings = {}
--   };
-- }
--
-- lspconfig.zk.setup({ on_attach = function(client, buffer) end })


-- vim.api.nvim_set_keymap('n', '<LeftMouse>', '<LeftMouse><cmd>lua vim.lsp.buf.hover({border = "single"})<CR>', { noremap=true, 
-- silent=true })
--
-- vim.api.nvim_set_keymap('n', '<RightMouse>', '<LeftMouse><cmd>lua vim.lsp.buf.definition()<CR>', { noremap=true, silent=true })


-- [[
-- https://stackoverflow.com/questions/67988374/neovim-lsp-auto-fix-fix-current
-- ]]

local function run_action(action)
    if action.edit or type(action.command) == "table" then
        if action.edit then
            vim.lsp.util.apply_workspace_edit(action.edit)
        end
        if type(action.command) == "table" then
            vim.lsp.buf.execute_command(action.command)
        end
    else
        vim.lsp.buf.execute_command(action)
    end
end

local function do_action(action, client)
    if
      not action.edit
      and client
      and type(client.resolved_capabilities.code_action) == "table"
      and client.resolved_capabilities.code_action.resolveProvider
    then
        client.request("codeAction/resolve", action, function(err, real)
            if err then
                return
            end
            if real then
                run_action(real)
            else
                run_action(action)
            end
        end)
    else
        run_action(action) 
    end
end

function X() 
    local params = vim.lsp.util.make_range_params() -- get params for current position
    params.context = {
        diagnostics = vim.lsp.diagnostic.get_line_diagnostics(),
        only = {"quickfix"}
    }

    local results, err = vim.lsp.buf_request_sync(
        0, -- current buffer
        "textDocument/codeAction", -- get code actions
        params,
        900
    )


    if err then return end

    if not results or vim.tbl_isempty(results) then
        -- print "No quickfixes!"
        return
    end

    -- we have an action!
    for cid, resp in pairs(results) do
        if resp.result then
            for _, result in pairs(resp.result) do 
                if result.kind == "source.organizeImports" then
                  -- P(result)
                  do_action(result, vim.lsp.get_client_by_id(cid))
                end
                return
            end
        end 
    end

    -- print "No quickfixes!"
end



