--- stacker/stack.lua
--------------------------------------------------------
-- This script allows you to hide windows,
-- and remembar what you have hidden.
-- To do so, an FILO stack is created ('state' in under code).
--
-- # Usage for client
-- push(client) 
--      : hide client and push it to stack
-- pop() 
--      : get the client from the front of stack
-- pickup(k) 
--      : get the client enumerated by k
--        (the clients in the stack is enumerated 
--         as 1 express the first client and len(stack) do last)
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
        push_front = function (self,value)
            local link = Link.new(value,nil,self.first)
            if link.next then
                link.next.previous = link
            end
            self.first = link
            if not self.last then
                self.last = link
            end
        end,
        pop_back = function (self)
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
        pop_front = function (self)
            local link = self.first
            if link.next then
                self.fisrt = link.next
                return link.value
            else
                return nil
            end
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
        pickup = function (self,k)
            local link = self.first
            if link then
                for i = 1,(k-1) do
                    link = link.next
                end
            end
            -- connect k-1 and k+1
            if link == self.first then
                return self:pop_front()
            elseif link == self.last then
                return self:pop_back()
            else
                link.previous.next = link.next
                link.next.previous = link.previous
                return link.value
            end
        end,
        -- FILO
        set_FILO = function (self)
            self.push = self.push_front
            self.pop  = self.pop_back
        end,
        set_FIFO = function (self)
            self.push = self.push_front 
            self.pop  = self.pop_front 
        end,
    }
    linklist:set_FILO()
    return linklist
end

stack = LinkList.new()

function push(c)
    c.hidden = true
    stack:push(c)
    wdg.update(stack)
end

function pop()
    local c = stack:pop()
    if c then
        c.hidden = false
        wdg.update(stack)
    end
end

function pickup(k)
    local c = stack:pickup(k)
    if c then
        c.hidden = false
        wdg.update(stack)
    end
end
