require('hs.ipc')
-- function reloadConfig(files)
--     doReload = false
--     for _,file in pairs(files) do
--         if file:sub(-4) == ".lua" then
--             doReload = true
--         end
--     end
--     if doReload then
--         hs.reload()
--     end
-- end
-- myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
-- hs.alert.show("Config loaded")

-- local inputEnglish = "com.apple.keylayout.US"
-- local esc_bind
-- com.apple.inputmethod.Korean.2SetKorean

-- hs -c 'hs.keycodes.currentSourceID("com.apple.inputmethod.Korean.2SetKorean")'

-- function convert_to_eng_with_esc()
-- 	local inputSource = hs.keycodes.currentSourceID()
-- 	if not (inputSource == inputEnglish) then
--         prev_source = inputSource
-- 		hs.keycodes.currentSourceID(inputEnglish)
-- 	end
-- 	esc_bind:disable()
-- 	hs.eventtap.keyStroke({}, 'escape')
-- 	esc_bind:enable()
-- end
--
-- esc_bind = hs.hotkey.new({}, 'escape', convert_to_eng_with_esc):enable()
