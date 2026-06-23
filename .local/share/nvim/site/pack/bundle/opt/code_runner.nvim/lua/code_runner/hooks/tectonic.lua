local utils = require("code_runner.hooks.utils")

local M = {}

local runner = utils.create_job_runner({ label = "Tectonic", stop_command = "TectonicStop" })

M.stop = runner.stop

--- @param flags? string
function M.build(flags)
  runner.start(("tectonic -X watch -x 'build %s'"):format(flags or ""))
end

--- @param flags? string
function M.single(flags)
  local root = vim.fn.expand("%:p")
  runner.start(("tectonic -X watch -x 'compile %s %s'"):format(root, flags or ""))
end

return M
