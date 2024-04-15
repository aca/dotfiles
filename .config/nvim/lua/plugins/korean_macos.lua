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
	local input_status = tonumber(vim.fn.system([[ remote-exec client-oneshot :11111 /Users/kyungrok.chung/.bin/darwin/im.english ]]))
	if input_status == 1 then
		vim.b.input_toggle_flag = true
	else
		vim.b.input_toggle_flag = false
	end
end

function _Fcitx2NonLatin()
	if vim.b.input_toggle_flag == true then
		vim.fn.system([[ remote-exec client-oneshot :11111 /Users/kyungrok.chung/.bin/darwin/im.korean ]])
		vim.b.input_toggle_flag = false
	end
end

vim.cmd([[
  augroup fcitx
    au InsertEnter * :lua _Fcitx2NonLatin()
    au InsertLeave * :lua _Fcitx2en()
    au CmdlineEnter [/\?] :lua _Fcitx2NonLatin()
    au CmdlineLeave [/\?] :lua _Fcitx2en()
  augroup END
]])
