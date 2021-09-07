local This = { keys = {} }

function This.run(index)
    if This.keys[index] == nil then
        local btn, macro = hs.dialog.textPrompt("Record your Macro!", "Enter the macro you want to record", "Enter your macro", "OK", "Cancel")

        if btn == "OK" then
            This.keys[index] = macro
            hs.notify.show("Registered Macro " .. index, macro, "Pressing the key again should replay the macro")
        else
            hs.notify.show("Cancelled recording", "Macro " .. index, "Press the key again to record your macro")
        end
    else
        hs.eventtap.keyStrokes(This.keys[index])
        hs.notify.show("Playing Macro", This.keys[index], "")
    end
end

function This.clear(index)
    if This.keys[index] == nil then
        hs.notify.show("Empty macro", "Macro " .. index, "Nothing to clear here buddy")
    else
        This.keys[index] = nil
        hs.notify.show("Cleared macro", "Macro " .. index, "Yay, you are free to record again")
    end
end

return This