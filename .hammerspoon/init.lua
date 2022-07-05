-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "m", function()
--   hs.eventtap.leftClick(hs.mouse.absolutePosition())
-- end)
--
-- hs.ipc.cliInstall()
local macro = require('macro')
hs.hotkey.bind({}, "f10", function() macro.run(1) end)
hs.hotkey.bind({}, "f11", function() macro.clear(1) end)

