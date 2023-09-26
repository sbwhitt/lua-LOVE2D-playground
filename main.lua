if arg[#arg] == "vsc_debug" then require("lldebugger").start() end

List = require('list')

function love.load()
    local _, _, flags = love.window.getMode()
    width, height = love.window.getDesktopDimensions(flags.display)
    love.window.setMode(width, height)

    -- cat = {
    --     img = love.graphics.newImage('cheesecat.jpg'),
    --     x = 0,
    --     y = 0
    -- }

    Circles = List.new()
    for i = 0, 10, 1 do
        Circles.add({
            radius = 10 + i,
            mass = (10 + i) / 5,
            x = 10 + (i * 40),
            y = 10,
            v_x = 0,
            v_y = i * 0.5
        })
    end
end

function love.keypressed(key, scancode, isrepeat)
    if key == 'q' then
        love.event.quit()
    end
end

function handleMoveXY(obj, amount)
    if love.keyboard.isDown('w') then
        obj.v_y = obj.v_y - amount
    end
    if love.keyboard.isDown('a') then
        obj.v_x = obj.v_x - amount
    end
    if love.keyboard.isDown('s') then
        obj.v_y = obj.v_y + amount
    end
    if love.keyboard.isDown('d') then
        obj.v_x = obj.v_x + amount
    end
end

function handleGrav(obj, amount)
    obj.v_y = obj.v_y + amount
end

function applyVelocity(obj)
    obj.x = obj.x + obj.v_x
    obj.y = obj.y + obj.v_y
end

function handleBounds(obj)
    if obj.x < 0 then
        obj.x = 0
        obj.v_x = (-1/obj.mass) * obj.v_x
    end
    if obj.x+obj.radius > width then
        obj.x = width-obj.radius
        obj.v_x = (-1/obj.mass) * obj.v_x
    end
    if obj.y < 0 then
        obj.y = 0
        obj.v_y = (-1/obj.mass) * obj.v_y
    end
    if obj.y > height-obj.radius then
        obj.y = height-obj.radius
        obj.v_y = (-1/obj.mass) * obj.v_y
    end
end

function love.update(dt)
    for i = 0, Circles.length-1, 1 do
        local c = Circles.items[i]
        handleMoveXY(c, 0.5)
        handleGrav(c, 0.1)
        applyVelocity(c)
        handleBounds(c)
    end
end

function love.draw()
    -- love.graphics.draw(cat.img, cat.x, cat.y)
    for i = 0, Circles.length-1, 1 do
        local c = Circles.items[i]
        love.graphics.circle('fill', c.x, c.y, c.radius)
    end
end
