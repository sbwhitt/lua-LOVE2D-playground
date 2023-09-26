local list = {}

function list.new()
    local res = {}
    res.length = 0
    res.items = {}
    res.add = function (item)
            if item == nil then return nil end
            res.items[res.length] = item
            res.length = res.length + 1
        end
    return res
end

return list