if os.getenv("HOSTNAME") ~= "kyungrokchung02" then
	return
end

function _Fcitx2en()
    vim.fn.system([[ /opt/homebrew/bin/hs -c "use_english()" ]])
end

function _Fcitx2NonLatin()
    vim.fn.system([[ /opt/homebrew/bin/hs -c "use_korean()" ]])
end

vim.cmd([[
  augroup fcitx
    au InsertEnter * :lua _Fcitx2NonLatin()
    au InsertLeavePre * :lua _Fcitx2en()
    au CmdlineEnter [/\?] :lua _Fcitx2NonLatin()
    au CmdlineLeave [/\?] :lua _Fcitx2en()
  augroup END
]])
