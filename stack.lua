
local awful = require("awful")

module("stacker.stack")

local capi = {
    mouse = mouse,
    client = client,
    screen = screen
}

stack_list = {}
stack_idx_in  = 1
stack_idx_out = 1

function push(c)
    --awful.client.floating.toggle(c);
    c.hidden = true
    stack_list[stack_idx_in] = c
    stack_idx_in = stack_idx_in + 1
end

function pop()
    --c = table.remove(stack_list) -- 末尾から一つ出す
    --c = stack_list[stack_idx_out]
    c = stack_list[stack_idx_out]
    stack_idx_out = stack_idx_out + 1
    c.hidden = false
end
