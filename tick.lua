local tick = {}

tick.time = 0

function tick.check(dt, limit)
    if tick.time > limit then
        tick.time = 0
        return true
    else
        tick.time = tick.time + dt
        return false
    end
end

return tick