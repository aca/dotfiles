local M = {}

-- local log = require("plenary.log").new({plugin = "blink-cmp-latex", level = "info", sync = false})
local log = {info = function(s) end, warn = function(s) end, error = function(s) end}

-- Config with defaults
local config = {
  prefix = "󰙅 ",
  separator = " > ",
}

-- Cache for efficiency
local cache = {
  bufnr = nil,
  changedtick = nil,
  node_id = nil,
  result = "",
}

-- Node types that typically have names we want to show
local NAME_NODE_TYPES = {
  -- Common identifier types
  "identifier",
  "name",
  "field_identifier",
  "property_identifier",
  "type_identifier",
  -- JSON
  "string",
}

-- Parent node types that contain named constructs
local SCOPE_NODE_TYPES = {
  -- Functions
  "function_declaration",
  "function_definition",
  "function_expression",
  "arrow_function",
  "method_declaration",
  "method_definition",
  -- Python
  "decorated_definition",
  -- Classes/Types
  "class_declaration",
  "class_definition",
  "struct_type",
  "type_declaration",
  "type_spec",
  "interface_declaration",
  "interface_definition",
  "enum_declaration",
  "enum_definition",
  -- Modules
  "module_declaration",
  "namespace_declaration",
  -- JSON
  "pair",
  "array",
  -- Nix
  "binding",
}

-- Convert to lookup table for O(1) access
local function to_set(list)
  local set = {}
  for _, v in ipairs(list) do
    set[v] = true
  end
  return set
end

local SCOPE_SET = to_set(SCOPE_NODE_TYPES)

-- Core function: compute contextline from a node
local function compute_contextline(node, bufnr)
  local path = {}
  local seen = {}

  while node do
    local node_type = node:type()

    -- Handle scope nodes
    if SCOPE_SET[node_type] then
      local name = nil

      -- Special handling for JSON pair
      if node_type == "pair" then
        local key_node = node:child(0)
        if key_node then
          name = vim.treesitter.get_node_text(key_node, bufnr)
          -- log.info(name)
          -- name = name:gsub('^"', ''):gsub('"$', '')
        end
      -- Special handling for Nix binding
      elseif node_type == "binding" then
        local attrpath = node:child(0)
        if attrpath and attrpath:type() == "attrpath" then
          name = vim.treesitter.get_node_text(attrpath, bufnr)
        end
      -- Special handling for arrays (get index)
      elseif node_type == "array" then
        -- Skip, index is handled below
      -- Special handling for Python decorated_definition
      elseif node_type == "decorated_definition" then
        local def = node:field("definition")
        if def and def[1] then
          name = M.find_name(def[1], bufnr)
        end
      else
        -- Generic: find first identifier-like child
        name = M.find_name(node, bufnr)
      end

      if name and not seen[name] then
        seen[name] = true
        table.insert(path, 1, name)
      end
    end

    -- Handle array index
    local parent = node:parent()
    if parent and parent:type() == "array" then
      local index = M.get_array_index(parent, node)
      if index then
        local idx_str = tostring(index)
        if not seen[idx_str] then
          seen[idx_str] = true
          table.insert(path, 1, idx_str)
        end
      end
    end

    node = parent
  end

  local out = table.concat(path, config.separator)
  if out == "" then
    return ""
  end
  return config.prefix .. out
end

-- Cached wrapper
function M.get_contextline()
  local bufnr = vim.api.nvim_get_current_buf()
  local changedtick = vim.api.nvim_buf_get_changedtick(bufnr)
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row = cursor[1] - 1
  local col = cursor[2]

  local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
  if not ok or not parser then
    return ""
  end

  local tree = parser:parse()[1]
  if not tree then
    return ""
  end

  local root = tree:root()
  local node = root:named_descendant_for_range(row, col, row, col)
  if not node then
    return ""
  end

  -- Check cache: same buffer, no modifications, same node
  local node_id = node:id()
  if cache.bufnr == bufnr
      and cache.changedtick == changedtick
      and cache.node_id == node_id then
    return cache.result
  end

  -- Compute and cache result
  local result = compute_contextline(node, bufnr)
  cache.bufnr = bufnr
  cache.changedtick = changedtick
  cache.node_id = node_id
  cache.result = result

  return result
end

-- Find name identifier in a node (recursive, limited depth)
function M.find_name(node, bufnr, depth)
  depth = depth or 0
  if depth > 3 then
    return nil
  end

  for child in node:iter_children() do
    local child_type = child:type()

    -- Direct identifier types
    if child_type == "identifier"
        or child_type == "name"
        or child_type == "field_identifier"
        or child_type == "property_identifier"
        or child_type == "type_identifier" then
      return vim.treesitter.get_node_text(child, bufnr)
    end

    -- Recurse into likely containers
    if child_type == "declarator"
        or child_type == "name"
        or child_type == "receiver" then
      local name = M.find_name(child, bufnr, depth + 1)
      if name then
        return name
      end
    end
  end

  return nil
end

-- Get 1-based index of node within parent array
function M.get_array_index(array_node, child_node)
  local index = 1
  for child in array_node:iter_children() do
    if child:named() then
      if child:id() == child_node:id() then
        return index
      end
      index = index + 1
    end
  end
  return nil
end

-- Setup function
function M.setup(opts)
  opts = opts or {}
  if opts.prefix ~= nil then
    config.prefix = opts.prefix
  end
  if opts.separator ~= nil then
    config.separator = opts.separator
  end
  -- Clear cache when config changes
  cache.bufnr = nil
end

return M
