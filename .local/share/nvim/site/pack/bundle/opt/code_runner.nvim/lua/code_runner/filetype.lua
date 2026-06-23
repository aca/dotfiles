local Singleton = require("code_runner.singleton")

-- Tabla de comandos para archivos nvim pre-cargada
local NVIM_FILES = {
  lua = "luafile %",
  vim = "source %",
}

-- Definition of the FileType class
local FileType = {}
FileType.__index = FileType

--- Constructor for the FileType class.
---@param utils table A utility object, required for execution.
function FileType:ctor(utils)
  assert(utils, "utils is required")
  self.opt = utils.opt
  self.utils = utils

  self.get_filename = function()
    return vim.fn.expand("%:t:r")
  end
end

--- Retrieves the command associated with the current file type.
---@return string The command for the current file type, or an empty string if none exists.
function FileType:getCommand()
  return self.utils:getCommand(vim.bo.filetype) or ""
end

--- Executes the current file based on its file type.
---@param mode string? The mode in which the command should run.
function FileType:run(mode)
  local command = self:getCommand()

  if command ~= "" then
    -- Hook before_run_filetype solo si existe
    local before_run = self.opt.before_run_filetype
    if before_run then
      before_run()
    end

    local filename = self.get_filename()
    self.utils:runMode(command, filename, mode)
    return
  end

  local cmd = NVIM_FILES[vim.bo.filetype]
  if cmd then
    vim.cmd(cmd)
  end
end

--- Executes a specific command provided as a function parameter.
---@param cmd string|table The command to execute, either as a string or a table.
function FileType:runFromFn(cmd)
  local command
  if type(cmd) == "table" then
    command = table.concat(cmd, " ")
  else
    command = cmd
  end

  assert(type(command) == "string", "The parameter 'cmd' must be a string or a table")

  local path = vim.fn.expand("%:p")
  local expanded_command = self.utils:replaceVars(command, path)

  self.utils:runMode(expanded_command, self.get_filename())
end

-- Convert FileType into a singleton
return Singleton(FileType)
