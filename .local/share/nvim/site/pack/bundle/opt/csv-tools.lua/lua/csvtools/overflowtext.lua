local M = {}
local function Split(s, delimiter)
    local result = {}
    for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
        table.insert(result, match)
    end
    return result
end
local ns_id = vim.api.nvim_create_namespace("csvoverview")
function M.OverFlow(line_num, header, id)
    local bnr = vim.fn.bufnr("%")
    local line = unpack(vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, true))
    local output = Split(line, ",")
    for count = 1, #header do
        if output[count] == nil then
            output[count] = ""
        end
        local len = string.len(output[count])
        if len < header[count] then
            for _ = 1, header[count] - len do
                output[count] = output[count] .. " "
            end
        elseif len > header[count] then
            --print(len,"  ",header[count])
            output[count] = output[count]:sub(1, header[count] - 2)
            output[count] = output[count] .. ".."
            --print("len=" , string.len(output[count]))
        end
        --print(header[count])
    end
    local virt_text = {}
    for count = 1, #output do
        if count % 2 == 0 then
            table.insert(virt_text, { output[count], "WhidHeader" })
        else
            table.insert(virt_text, { output[count], "WhidSubHeader" })
        end
        table.insert(virt_text, { "|" })
        --table.insert(virt_text,{text,"WhidHeader"})
        --print(output[count])
    end
    local opts = {
        end_line = 1,
        id = id,
        virt_text = virt_text,
        virt_text_pos = "overlay",
        -- virt_text_win_col = 20,
    }
    --highlighttop2(bnr, text)
    --print("sss")
    return {
        bnr = bnr,
        markid = vim.api.nvim_buf_set_extmark(bnr, ns_id, line_num - 1, 0, opts),
        ns_id = ns_id,
        id = id,
    }
end
function M.OverFlowTitle(line_num, header, id)
    local bnr = vim.fn.bufnr("%")
    local line = unpack(vim.api.nvim_buf_get_lines(0, 0, 1, true))
    local output = Split(line, ",")
    for count = 1, #header do
        if output[count] == nil then
            output[count] = ""
        end
        local len = string.len(output[count])
        if len < header[count] then
            for _ = 1, header[count] - len do
                output[count] = output[count] .. " "
            end
        elseif len > header[count] then
            --print(len,"  ",header[count])
            output[count] = output[count]:sub(1, header[count] - 2)
            output[count] = output[count] .. ".."
            --print("len=" , string.len(output[count]))
        end
        --print(header[count])
    end
    local virt_text = {}
    for count = 1, #output do
        if count % 2 == 0 then
            table.insert(virt_text, { output[count], "WhidHeader" })
        else
            table.insert(virt_text, { output[count], "WhidSubHeader" })
        end
        table.insert(virt_text, { "|" })
        --table.insert(virt_text,{text,"WhidHeader"})
        --print(output[count])
    end
    local opts = {
        end_line = 1,
        id = id,
        virt_text = virt_text,
        virt_text_pos = "overlay",
        -- virt_text_win_col = 20,
    }
    --highlighttop2(bnr, text)
    --print("sss")
    return {
        bnr = bnr,
        markid = vim.api.nvim_buf_set_extmark(bnr, ns_id, line_num - 1, 0, opts),
        ns_id = ns_id,
        id = id,
    }
end
return M
