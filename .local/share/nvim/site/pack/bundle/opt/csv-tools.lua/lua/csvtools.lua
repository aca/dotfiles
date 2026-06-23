--local api = vim.api
local highlight = require("csvtools.highlight")
local overflow = require("csvtools.overflowtext")
local getheader = require("csvtools.header")
local M = {
    before = 20,
    after = 20,
    clearafter = true,
    showoverflow = true,
    titleflow = true,
}
-- buf's status
local Status = {
    winid = nil,
    buf = nil,
    mainwindowbuf = nil,
    header = {},
    overflowtext = {},
}
--function M.printheader()
--    return Status.header
--end
function M.Ifclear()
    if M.clearafter then
        M.clearafter = false
    else
        M.clearafter = true
    end
end

function M.NewWindow()
    -- before create new top window ,close the window now
    M.CloseWindow()
    Status.mainwindowbuf = vim.api.nvim_get_current_buf()
    --local file = vim.api.nvim_buf_get_name(0)
    --local f = io.open(file, "r")
    local messages = unpack(vim.api.nvim_buf_get_lines(Status.mainwindowbuf, 0, 1, true))
    if messages == nil then
        return
    end
    --f:close()
    messages = messages:gsub("%,", "|")
    local buf = vim.api.nvim_create_buf(false, true) -- create new emtpy buffer
    vim.cmd([[sview]])
    vim.api.nvim_win_set_height(0, 1)
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { messages })
    vim.api.nvim_win_set_buf(win, buf)
    highlight.highlighttop(buf, messages)
    Status.winid = win
    Status.buf = buf
    M.add_mappings()
end

function M.CloseWindow()
    if Status.winid ~= nil then
        -- top window may close by people, so use pcall
        pcall(vim.api.nvim_win_close, Status.winid, true)
        Status.winid = nil
        Status.buf = nil
        Status.header = {}
    end
end

--@param line number
--@param length string
--@return number number
local function getrange(line, length)
    local start = 1
    if line - M.before > 1 then
        start = line - M.before
    end
    local final = length
    if line + M.after < length then
        final = line + M.after
    end
    return start, final
end
-- only 3 overflow
local function getrangeoverflow(line, length)
    local start = 1
    if line - 1 > 1 then
        start = line - 1
    end
    local final = length
    if line + 1 < length then
        final = line + 1
    end
    return start, final
end

function M.CloseOverFlow()
    if M.showoverflow then
        for count = 1, #Status.overflowtext do
            --print(Status.overflowtext[count].bnr,Status.overflowtext[count].ns_id,Status.overflowtext[count].id)
            vim.api.nvim_buf_del_extmark(
                Status.overflowtext[count].bnr,
                Status.overflowtext[count].ns_id,
                Status.overflowtext[count].id
            )
        end
    end
end
function M.Highlight()
    if vim.o.filetype == "csv" then
        Status.header = getheader.Header()
        Status.overflowtext = {}
        -- get the buffer id
        Status.mainwindowbuf = vim.api.nvim_get_current_buf()
        local line, _ = unpack(vim.api.nvim_win_get_cursor(0))
        --print(line)
        local length = vim.api.nvim_buf_line_count(Status.mainwindowbuf)
        if M.clearafter then
            vim.api.nvim_buf_clear_namespace(Status.mainwindowbuf, -1, 0, length)
        end
        local start, final = getrange(line, length)
        local start2, final2 = getrangeoverflow(line, length)
        --print(start)
        --print(final)
        highlight.highlight(Status.mainwindowbuf, line)
        for i = start, line - 1, 1 do
            highlight.highlight(Status.mainwindowbuf, i)
        end
        for i = line + 1, final, 1 do
            highlight.highlight(Status.mainwindowbuf, i)
        end
        if M.showoverflow then
            table.insert(Status.overflowtext, overflow.OverFlow(line, Status.header, 1))
            local count = 2
            for i = start2, line - 1, 1 do
                table.insert(Status.overflowtext, overflow.OverFlow(i, Status.header, count))
                --highlight.highlight(M.mainwindowbuf, count)
                count = count + 1
            end
            for i = line + 1, final2, 1 do
                table.insert(Status.overflowtext, overflow.OverFlow(i, Status.header, count))
                --highlight.highlight(M.mainwindowbuf, count)
                count = count + 1
            end
            if line - 2 > 0 and M.titleflow then
                table.insert(Status.overflowtext, overflow.OverFlowTitle(line - 2, Status.header, 4))
            end
        end
    end
end
-- delete the mark before
function M.deleteMark()
    if M.showoverflow and Status.overflowtext[1] ~= nil then
        vim.api.nvim_buf_del_extmark(
            Status.overflowtext[1].bnr,
            Status.overflowtext[1].ns_id,
            Status.overflowtext[1].id
        )
    end
end

function M.add_mappings()
    Status.mainwindowbuf = vim.api.nvim_get_current_buf()
    --print(M.mainwindowbuf)
    local opts = { nowait = true, noremap = true, silent = true }
    --vim.api.nvim_buf_set_keymap(M.mainwindowbuf, "n", "<leader>td", ":lua require'csvtools'.CloseWindow<cr>", opts)
    vim.api.nvim_buf_set_keymap(
        Status.mainwindowbuf,
        "n",
        "<leader>tf",
        "<cmd>lua require'csvtools'.NewWindow()<cr>",
        opts
    )
    if Status.buf ~= nil then
        vim.api.nvim_buf_set_keymap(Status.buf, "n", "<leader>td", "<cmd>lua require'csvtools'.CloseWindow()<cr>", opts)
    end
    vim.api.nvim_buf_set_keymap(
        Status.mainwindowbuf,
        "n",
        "<leader>td",
        "<cmd>lua require'csvtools'.CloseWindow()<cr>",
        opts
    )

    vim.api.nvim_buf_set_keymap(
        Status.mainwindowbuf,
        "n",
        "<leader>tr",
        "<cmd>lua require'csvtools'.CloseOverFlow()<cr>",
        opts
    )
    vim.api.nvim_buf_set_keymap(
        Status.mainwindowbuf,
        "n",
        "<leader>tg",
        "<cmd>lua require'csvtools'.Ifclear()<cr>",
        opts
    )
    vim.api.nvim_buf_set_keymap(
        Status.mainwindowbuf,
        "n",
        "<up>",
        "<cmd>-1<cr><cmd>lua require'csvtools'.Highlight()<cr>",
        opts
    )
    vim.api.nvim_buf_set_keymap(
        Status.mainwindowbuf,
        "n",
        "k",
        "<cmd>-1<CR><cmd>lua require'csvtools'.Highlight()<cr>",
        opts
    )
    vim.api.nvim_buf_set_keymap(
        Status.mainwindowbuf,
        "n",
        "<down>",
        "<cmd>+1<cr><cmd>lua require'csvtools'.Highlight()<cr>",
        opts
    )
    vim.api.nvim_buf_set_keymap(
        Status.mainwindowbuf,
        "n",
        "j",
        "<cmd>+1<cr><cmd>lua require'csvtools'.Highlight()<cr>",
        opts
    )
end
function M.setup(opts)
    M = vim.tbl_deep_extend("force", M, opts)
end
return M
