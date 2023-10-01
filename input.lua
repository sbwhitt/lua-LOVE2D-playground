List = require('list')

local input = {}

function input.new()
    local i = {}

    i.active = true
    i.length = 0
    i.letters = List.new()
    i.tick = require('tick')

    i.addLetter = function (l)
        i.letters.add(l)
        i.length = i.length + 1
    end

    i.update = function (dt)
        if i.tick.check(dt, 0.5) then i.active = false end
    end

    i.stop = function ()
        i.active = false
    end

    return i
end

return input