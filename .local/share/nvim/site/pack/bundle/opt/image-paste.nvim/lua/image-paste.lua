local M = {}

local api = vim.api
local fn = vim.fn

local options = {
  -- The imgur application client key
  -- This is easily obtained at https://api.imgur.com/oauth2/addclient
  imgur_client_id = "",

  -- The script used to produce te image on STDOUT
  paste_script = [[osascript -e "get the clipboard as «class PNGf»" | sed "s/«data PNGf//; s/»//" | xxd -r -p]],

  -- The name of the image in the alt attribute
  image_name = "clipboard.png",
}

-- PPI that is considered HDPI
local high_ppi = 72 * 2

function M.paste_image()
  local template_md = "![%s](%s)"
  local template_html = [[<img alt="%s" width="%s" src="%s" />]]

  local placeholder_alt = string.format("Uploading %s…", options.image_name)
  local placeholder = string.format(template_md, placeholder_alt, "")

  -- Inserrt the upload template
  local buffer = api.nvim_get_current_buf()
  local row, col = unpack(api.nvim_win_get_cursor(0))
  api.nvim_buf_set_text(buffer, row - 1, col, row - 1, col, { placeholder })
  api.nvim_win_set_cursor(0, { row, col + placeholder:len() + 1 })

  -- Mark the location of the template for replacing later
  local mark_ns = api.nvim_create_namespace("")
  local mark_id = api.nvim_buf_set_extmark(
    buffer,
    mark_ns,
    row - 1,
    col,
    { end_col = col + placeholder:len(), hl_group = "Whitespace" }
  )

  -- Determine the image width and PPI
  -- This command will execute quite quick, so we don't need to worry too much
  -- about it returning after the upload is complete
  local width = nil
  local is_hdpi = false

  local get_width_command = string.format(
    "%s | identify -ping -units PixelsPerInch -format '%%w,%%x' -",
    options.paste_script
  )

  fn.jobstart(get_width_command, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      local str_width, str_ppi = unpack(vim.split(fn.join(data), ","))
      local ppi = tonumber(str_ppi, 10)
      width = tonumber(str_width, 10)

      if width ~= nil and ppi == high_ppi then
        is_hdpi = true
        width = width / 2
      end
    end,
  })

  local upload_command = string.format(
    [[%s \
      | curl --silent \
        --fail \
        --request POST \
        --form "image=@-" \
        --header "Authorization: Client-ID %s" \
        "https://api.imgur.com/3/upload" \
      | jq --raw-output .data.link
  ]],
    options.paste_script,
    options.imgur_client_id
  )

  local url = nil

  -- Start uploading
  fn.jobstart(upload_command, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      url = fn.join(data):gsub("^%s*(.-)%s*$", "%1")
    end,
    on_exit = function(_, exit_code)
      local failed = url == "" or width == "" or exit_code ~= 0
      local replacement = ""

      -- Create the HTML replacement string
      if not failed then
        if is_hdpi and width ~= nil then
          replacement = string.format(template_html, options.image_name, width, url)
        else
          replacement = string.format(template_md, options.image_name, url)
        end
      else
        print("Failed to upload or paste image")
      end

      -- Locate the mark
      local mark_row, mark_col =
        unpack(api.nvim_buf_get_extmark_by_id(buffer, mark_ns, mark_id, {}))

      -- Update the line containing the mark
      api.nvim_buf_del_extmark(buffer, mark_ns, mark_id)
      api.nvim_buf_set_text(
        buffer,
        mark_row,
        mark_col,
        mark_row,
        mark_col + placeholder:len(),
        { replacement }
      )
    end,
  })
end

function M.setup(opts)
  options = vim.tbl_deep_extend("force", options, opts or {})

  if options.imgur_client_id == "" then
    error("Missing imgur_client_id in image-paste.nvim")
  end
end

return M
