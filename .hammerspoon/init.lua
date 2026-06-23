require("hs.ipc")
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

-- com.apple.inputmethod.Korean.2SetKorean

-- hs -c 'hs.keycodes.currentSourceID("com.apple.inputmethod.Korean.2SetKorean")'

local inputEnglish = "com.apple.keylayout.US"
local esc_bind
local function convert_to_eng_with_esc()
	local inputSource = hs.keycodes.currentSourceID()
	if not (inputSource == inputEnglish) then
		hs.keycodes.currentSourceID(inputEnglish)
	end
	esc_bind:disable()
	hs.eventtap.keyStroke({}, 'escape')
	esc_bind:enable()
end

esc_bind = hs.hotkey.new({}, 'escape', convert_to_eng_with_esc):enable()

-- local inputEnglish = "com.apple.keylayout.US"
-- local esc_bind


-- local input_toggle_flag = false
-- local eng_layout = "com.apple.keylayout.US"
--
-- function use_english()
--     if hs.keycodes.currentSourceID() ~= eng_layout then
--         input_toggle_flag = true
--         hs.keycodes.currentSourceID(eng_layout)
--     else
--         input_toggle_flag = false
--     end
-- end
--
-- function use_korean()
--     if input_toggle_flag == true then
--         hs.keycodes.currentSourceID('com.apple.inputmethod.Korean.2SetKorean')
--     end
-- end
