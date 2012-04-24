stacker
===============

Stacker is an Awesome 3 extention that implements window stacking.

This extention allows you to hide clients (windows) like minimize
and push it to hidden client stack(FILO) at the same time.
The hidden client list is shown in a status widget,
and you can pop(make unhidden) the firstly hidden client.
In addtion to pop, 
this extention reserve a function pickup() 
which pick up the client from the middle of the stack by index.

Usage
----------------
1. Go to configuration directiory `$XDG_CONFIG_HOME/awesome`
, usually `~/.config/awesome`
2. Clone repository:
`git clone https://termoshtt@github.com/termoshtt/awesome-stacker`
3. add keymap `stacker.stack.push` to client key something like:
`awful.key({modkey},"s" , stacker.stack.push)`
4. add keymap `stacker.stack.pop` to global key:
`awful.key({modkey, "Shift"}, s, stacker.stack.pop ")`
5. add keymap `stacker.stack.pickup` to global key
`awful.key({modkey}, 1, function () stacker.stack.pickup(1) end")`
`awful.key({modkey}, 2, function () stacker.stack.pickup(2) end")`
`awful.key({modkey}, 3, function () stacker.stack.pickup(3) end")`
`...`
, or using for loop:
<code>
for i = 1,9 do
    globalkeys = awful.util.table.join( globalkeys, 
        awful.key({modkey, "Mod1"}, i ,function ()
            stacker.stack.pickup(i) 
        end)
    )
end
</code>
6. Lastly, add Hidden client list widget `stacker.widget.widget` to your system tray.

