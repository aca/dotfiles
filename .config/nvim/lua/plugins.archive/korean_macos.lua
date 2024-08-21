if
	os.getenv("HOSTNAME")
	~= "rok-t" -- 
		.. "oss-nix"
then
	return
end

if vim.fn.executable('remote-exec') ~= 1 then
    return
end

function _Fcitx2en()
	vim.fn.system([[ remote-exec client-oneshot :11111 '/opt/homebrew/bin/hs -c "use_english()"' ]])
end

function _Fcitx2NonLatin()
     vim.fn.system([[ remote-exec client-oneshot :11111 '/opt/homebrew/bin/hs -c "use_korean()"' ]])
end

-- vim.cmd([[
--   augroup fcitx
--     au InsertEnter * :lua _Fcitx2NonLatin()
--     au InsertLeavePre * :lua _Fcitx2en()
--     au CmdlineEnter [/\?] :lua _Fcitx2NonLatin()
--     au CmdlineLeave [/\?] :lua _Fcitx2en()
--   augroup END
-- ]])
