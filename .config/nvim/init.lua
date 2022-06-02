local xdg_config = vim.fn.stdpath('config') .. '/lua'

package.path = string.format(
   '%s/?.ljbc;%s',
   xdg_config,
   package.path
)

-- require("setup")
