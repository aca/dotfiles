hs.hotkey.bind({"cmd", "alt", "ctrl"}, "m", function()
  hs.eventtap.leftClick(hs.mouse.absolutePosition())
end)

hs.ipc.cliInstall()
