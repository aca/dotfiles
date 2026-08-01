if os.getenv('SSH_TTY') ~= nil then
  return
end

if vim.fn.executable('fcitx5-remote') ~= 1 then
    return
end

local fcitx_cmd = 'fcitx5-remote'

function _Fcitx2en()
  local input_status = tonumber(vim.fn.system(fcitx_cmd))
  -- input status 0: English, 1: Non-Latin
  if input_status == 2 then
    -- input_toggle_flag means whether to restore the state of fcitx
    vim.b.input_toggle_flag = true
    -- switch to English input
    vim.fn.system(fcitx_cmd .. ' -c')
  end
end

function _Fcitx2NonLatin()
  if vim.b.input_toggle_flag == nil then
    vim.b.input_toggle_flag = false
  elseif vim.b.input_toggle_flag == true then
    -- switch to Non-Latin input
    vim.fn.system(fcitx_cmd .. ' -o')
    vim.b.input_toggle_flag = false
  end
end

vim.cmd[[
  augroup fcitx
    au InsertEnter * :lua _Fcitx2NonLatin()
    au InsertLeave * :lua _Fcitx2en()
    au CmdlineEnter [/\?] :lua _Fcitx2NonLatin()
    au CmdlineLeave [/\?] :lua _Fcitx2en()
  augroup END
]]
