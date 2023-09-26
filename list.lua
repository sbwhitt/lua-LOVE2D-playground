local list = {}

function list.new()
    local l = {}
    l.length = 0
    l.items = {}
    l.add = function (item)
            if item == nil then return nil end
            l.items[l.length] = item
            l.length = l.length + 1
        end
    l.remove = function (index)
            if index < 0 or index >= l.length then return nil end
            l.items[index] = nil
            for i = index, l.length-2, 1 do
                l.items[i] = l.items[i+1]
            end
            l.length = l.length - 1
        end
    return l
end

return list