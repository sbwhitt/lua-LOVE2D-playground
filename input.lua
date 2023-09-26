local input = {
    active = false,
    length = 0
}

function input.add()
    input.length = input.length + 1
end

function input.toggle()
    input.active = not input.active
    input.length = 0
end

return input