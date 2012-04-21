
local capi = {
    widget = widget,
}

module("stacker.widget")

widget = capi.widget({type = "textbox"})

function update (stack)
    local link = stack.first
    if not link then
        widget.text = ""
        return nil
    end

    widget.text = "[HiddenWindows]"
    while link ~= nil do
        local c = link.value
        widget.text = widget.text .. "|" .. c.name
        link = link.next
    end
end

