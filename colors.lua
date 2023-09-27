local colors = {
    red = {1, 0, 0},
    green = {0, 1, 0},
    blue = {0, 0, 1},
    yellow = {1, 1, 0},
    magenta = {1, 0, 1},
    cyan = {0, 1, 1},
    orange = {1, 0.66, 0},
    purple = {0.66, 0, 1},
    brown = {0.75, 0.66, 0},
    white = {1, 1, 1},
    gray = {0.75, 0.75, 0.75}
}

function colors.random()
    return {
        math.random(),
        math.random(),
        math.random()
    }
end

return colors