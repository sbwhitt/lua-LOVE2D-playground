if arg[#arg] == "vsc_debug" then require("lldebugger").start() end

math.randomseed(os.clock())

List = require('list')
Input = require('input')
Alpha = require('alpha')
Colors = require('colors')
Timer = require('timer')

function love.load()
    local _, _, flags = love.window.getMode()
    Width, Height = love.window.getDesktopDimensions(flags.display)
    love.window.setMode(Width, Height)

    Letters = List.new()
    Inputs = List.new()
    TypeTimer = Timer.new()
    CurrentInput = Input.new()
end

function love.keypressed(key, scancode, isrepeat)
    if key == 'escape' then
        love.event.quit()
    end
    -- if Alpha[key] then
    --     Letters.add({
    --         val = Alpha[key],
    --         radius = 16,
    --         mass = math.random(2, 5),
    --         x = math.random(10, Width - 10),
    --         y = 10,
    --         v_x = math.random(),
    --         v_y = math.random()
    --     })
    -- end
end

function handleActiveKeys(keys, CurrentInput)
    local typing = false
    for k, v in pairs(keys) do
        if love.keyboard.isDown(k) then
            v.active = true
            local l = {
                val = Alpha[k],
                radius = 16,
                mass = math.random(2, 5),
                x = 10,
                y = 10,
                v_x = math.random(),
                v_y = math.random()
            }
        CurrentInput.addLetter(l)
        Letters.add(l)
        typing = true
        else
            v.active = false
        end
    end
    return typing
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

function applyJump(obj)
    obj.v_y = obj.v_y -1
end

function updateCurrentInput(dt)
    CurrentInput.update(dt)
    if not CurrentInput.active then
        CurrentInput.stop()
        local i = Input.new()
        Inputs.add(i)
        CurrentInput = i
    end
end

function love.update(dt)
    if TypeTimer.check(dt, 0.13) then
        if not handleActiveKeys(Alpha, CurrentInput) then
            updateCurrentInput(dt)
        else
            CurrentInput.timer.reset()
        end
    end

    for i = 0, Letters.length-1, 1 do
        local l = Letters.items[i]        
        -- w, a ,s, d controls
        -- if not Input.active then handleMoveXY(l, 0.5) end
        -- gravity
        applyAccY(l, 0.3)
        -- if math.random() > 0.9 then applyJump(l) end
        applyVelocity(l)
        handleBounds(l)
        -- remove at bottom
        if l.y > Height then
            Letters.remove(i)
        end
    end
end

function drawCurrentInput()
    for i=0, CurrentInput.letters.length-1, 1 do
        love.graphics.print(CurrentInput.letters.items[i].val, Width/2 + (i * 12), 10)
    end
end

function love.draw()
    for i = 0, Letters.length-1, 1 do
        local l = Letters.items[i]
        love.graphics.print(l.val, l.x, l.y)
    end

    drawCurrentInput()
    -- if Input.active then love.graphics.print('inputting', Width/2, Height/2) end
end
