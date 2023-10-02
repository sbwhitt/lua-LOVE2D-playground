local timer = {}

function timer.new()
    local t = {}
    
    t.time = 0

    function t.check(dt, limit)
        if t.time > limit then
            t.time = 0
            return true
        else
            t.time = t.time + dt
            return false
        end
    end

    function t.reset()
        t.time = 0
    end

    return t
end

return timer