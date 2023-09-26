function love.load()
    local _, _, flags = love.window.getMode()
    local w, h = love.window.getDesktopDimensions(flags.display)
    love.window.setMode(w, h)

    cat = {
        img = love.graphics.newImage('cheesecat.jpg'),
        x = 0,
        y = 0
    }
end

function love.keypressed(key, scancode, isrepeat)
    if key == 'q' then
        love.event.quit()
    end
end

function love.update(dt)
    if love.keyboard.isDown('w') then
        cat.y = cat.y - 5
    end
    if love.keyboard.isDown('a') then
        cat.x = cat.x - 5
    end
    if love.keyboard.isDown('s') then
        cat.y = cat.y + 5
    end
    if love.keyboard.isDown('d') then
        cat.x = cat.x + 5
    end
end

function love.draw()
    love.graphics.draw(cat.img, cat.x, cat.y)
end
