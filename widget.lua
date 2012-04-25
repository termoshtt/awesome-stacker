
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

    -- TODO make this widget text configuable by clinet code(rc.lua)
    widget.text = "[HiddenWindows]"
    local i = 0
    while link ~= nil do
        local c = link.value
        widget.text = widget.text .. "|" .. c.name
        link = link.next
        i = i + 1
    end
    widget.text = widget.text .. "[" .. i  .. "]"
end

