if os.getenv('HOSTNAME') ~= "rok-toss-nix" then
  return
end

function _Fcitx2en()
  local input_status = tostring(vim.fn.system([[ remote-exec client-oneshot :11111 "hs -c 'hs.keycodes.currentSourceID()'" ]]))
  -- input status 0: English, 1: Non-Latin
  if input_status ~= "com.apple.keylayout.US" then
    -- input_toggle_flag means whether to restore the state of fcitx
    vim.b.input_toggle_flag = true
    -- switch to English input
    local output = vim.fn.system([[ remote-exec client-oneshot :11111 "hs -c \"hs.keycodes.currentSourceID('com.apple.keylayout.US')\"" ]])
    print(tostring(output))
  end
end

function _Fcitx2NonLatin()
  if vim.b.input_toggle_flag == nil then
    vim.b.input_toggle_flag = false
  elseif vim.b.input_toggle_flag == true then
    -- switch to Non-Latin input
    vim.fn.system([[ remote-exec client-oneshot :11111 "hs -c \"hs.keycodes.currentSourceID('com.apple.inputmethod.Korean.2SetKorean')\"" ]])
    vim.b.input_toggle_flag = false
  end
end

vim.cmd[[
  augroup fcitx
    " au InsertEnter * :lua _Fcitx2NonLatin()
    au InsertLeave * :lua _Fcitx2en()
    au CmdlineEnter [/\?] :lua _Fcitx2NonLatin()
    au CmdlineLeave [/\?] :lua _Fcitx2en()
  augroup END
]]
