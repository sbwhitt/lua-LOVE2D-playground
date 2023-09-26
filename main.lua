function love.load()
    local _, _, flags = love.window.getMode()
    local w, h = love.window.getDesktopDimensions(flags.display)
    love.window.setMode(w, h)

    -- cat = {
    --     img = love.graphics.newImage('cheesecat.jpg'),
    --     x = 0,
    --     y = 0
    -- }

    numCircles = 10
    circles = {}
    for i = 0, numCircles, 1 do
        circles[i] = {
            radius = 10,
            x = i * 40,
            y = 0
        }
    end
end

function love.keypressed(key, scancode, isrepeat)
    if key == 'q' then
        love.event.quit()
    end
end

function handleMoveXY(obj)
    if love.keyboard.isDown('w') then
        obj.y = obj.y - 5
    end
    if love.keyboard.isDown('a') then
        obj.x = obj.x - 5
    end
    if love.keyboard.isDown('s') then
        obj.y = obj.y + 5
    end
    if love.keyboard.isDown('d') then
        obj.x = obj.x + 5
    end
end

function love.update(dt)
    for i = 0, numCircles, 1 do
        handleMoveXY(circles[i])
    end
end

function love.draw()
    -- love.graphics.draw(cat.img, cat.x, cat.y)
    for i = 0, numCircles, 1 do
        love.graphics.circle('fill', circles[i].x, circles[i].y, circles[i].radius)
    end
end
