local calculate_distance = require("calculate_distance")
math.randomseed(os.time())

function love.load()
    target = {}
    target.x = 300
    target.y = 300
    target.radius = 50

    score = 0
    timer = 0
    gameState = 1

    gameFont = love.graphics.newFont(40)

    sprites = {
        sky = love.graphics.newImage('sprites/sky.png'),
        target = love.graphics.newImage('sprites/target.png'),
        crosshairs = love.graphics.newImage('sprites/crosshairs.png')
    }

end

function love.update(dt)
    if timer > 0 then
        timer = timer - dt
    end
    if timer < 0 then
        timer = 0
        gameState = 1
        score = 0
    end

    if score < 0 then
        score = 0

    end
    

end

function love.draw()

    love.graphics.draw(sprites.sky, 0, 0)

    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(gameFont)
    love.graphics.print("Score: "..score, 0, 0)
    love.graphics.print("Time: "..math.ceil(timer).."s", love.graphics.getWidth() - 200, 0)

    if gameState == 1 then
        love.graphics.printf("Click anywhere to begin", 0, 250, love.graphics.getWidth(), "center")

    end

    if gameState == 2 then

        love.graphics.draw(sprites.target, target.x - target.radius, target.y - target.radius)
        love.graphics.draw(sprites.crosshairs, love.mouse.getX()-20, love.mouse.getY()-20)
    end

    love.mouse.setVisible(false)
end

function love.mousepressed(x, y, button, istouch, presses)

    if button == 1 and gameState == 2 then
        hit_the_target(x, y)

    elseif button == 1 and gameState == 1 then
        gameState = 2
        timer = 10
    end

    if button == 2 and gameState == 2 then
        verify = hit_the_target(x, y)
        if verify == true then
            score = score + 1
            timer = timer - 1

        end
        

    end

end

function change_circle_position()
    target.x = math.random(target.radius, love.graphics.getWidth() - target.radius)
    target.y = math.random(target.radius, love.graphics.getHeight() - target.radius)


end

function hit_the_target(x, y)
    local mouse2target = calculate_distance.calculateDistance(x, y, target.x, target.y)

        if target.x == x and target.y == y then
            score = score + 5
            love.graphics.setColor(0,1,0)
            love.graphics.print("Perfect!", math.ceil(love.graphics.getWidth()/2), math.ceil(love.graphics.getHeight()/2))
            love.graphics.setColor(1, 1, 1)
            change_circle_position()
            return true
        elseif mouse2target < target.radius then
            score = score + 1
            love.graphics.print("", math.ceil(love.graphics.getWidth()/2), math.ceil(love.graphics.getHeight()/2))
            change_circle_position()
            return true
        else
            score = score - 1
            return false
        end


end

