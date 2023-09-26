if arg[#arg] == "vsc_debug" then require("lldebugger").start() end

List = require('list')
Input = require('input')
Alpha = require('alpha')

function love.load()
    local _, _, flags = love.window.getMode()
    Width, Height = love.window.getDesktopDimensions(flags.display)
    love.window.setMode(Width, Height)

    Letters = List.new()
end

function love.keypressed(key, scancode, isrepeat)
    if key == 'return' then
        Input.toggle()
        if Input.active then Letters.clear() end
        return
    end
    if Input.active and Alpha[key] then
        Letters.add({
            char = Alpha[key],
            radius = 16,
            mass = 2,
            x = 10 + Input.length * 10,
            y = 10,
            v_x = 0,
            v_y = Input.length / 2
        })
        Input.add()
        return
    end
    if key == 'q' or key == 'escape' then
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

function applyAccY(obj, amount)
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
    if obj.x+obj.radius > Width then
        obj.x = Width-obj.radius
        obj.v_x = (-1/obj.mass) * obj.v_x
    end
    if obj.y < 0 then
        obj.y = 0
        obj.v_y = (-1/obj.mass) * obj.v_y
    end
    if obj.y > Height-obj.radius then
        obj.y = Height-obj.radius
        obj.v_y = (-1/obj.mass) * obj.v_y
    end
end

function love.update(dt)
    if Input.active then return end
    for i = 0, Letters.length-1, 1 do
        local l = Letters.items[i]
        -- w, a ,s, d controls
        handleMoveXY(l, 0.5)
        -- gravity
        applyAccY(l, 0.3)
        applyVelocity(l)
        handleBounds(l)
    end
end

function love.draw()
    for i = 0, Letters.length-1, 1 do
        local l = Letters.items[i]
        love.graphics.print(l.char, l.x, l.y)
    end

    if Input.active then love.graphics.print('inputting', Width/2, Height/2) end
end
