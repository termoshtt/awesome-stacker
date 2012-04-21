--- stacker/stack.lua
--------------------------------------------------------
-- This script allows you to hide windows,
-- and remembar what you have hidden.
-- To do so, an LIFO stack is created ('state' in under code).
--
-- # Usage for client
-- push(client) 
--      : hide client and push it to stack
-- pop() 
--      : get the client from the front of stack(LIFO)
-- get(k) (TODO : will be created)
--      : get the client enumerated by k
--
-- BUG:
--  pop() missing when all windows are hidden
--------------------------------------------------------
local awful = require("awful")
local capi = {
    mouse = mouse,
    client = client,
    screen = screen
}

local wdg = require("stacker.widget")

module("stacker.stack")

------------------------------------------
-- class LinkList
------------------------------------------
Link = {}
function Link.new (value,previouslink,nextlink)
    local link = {
        value = value,
        next = nextlink,
        previous = previouslink,
    }
    return link
end
LinkList = {}
function LinkList.new ()
    local linklist = {
        first = nil,
        last = nil,
        -- for FILO stack use
        push = function (self,value)
            local link = Link.new(value,nil,self.first)
            if link.next then
                link.next.previous = link
            end
            self.first = link
            if not self.last then
                self.last = link
            end
        end,
        pop = function (self)
            local link = self.last
            if not link then
                return nil
            end 
            self.last = link.previous
            if self.last then
                self.last.next = nil
            else
                self.first = nil
            end
            return link.value
        end,
        len = function (self)
            local link = self.first
            local length = 0
            while link ~= nil do
                length = length + 1
                link = link.next
            end
            return length
        end,
    }
    return linklist
end

stack = LinkList.new()

function push(c)
    c.hidden = true
    stack:push(c)
    wdg.update(stack)
end

function pop()
    c = stack:pop()
    c.hidden = false
    wdg.update(stack)
end
