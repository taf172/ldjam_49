local secsi = require 'libs.secsi'
local Game = require 'entities.game'

local RenderSystem = secsi.system{ 'x', 'y', 'color', 'layer', 'render'}
RenderSystem.group = 'draw'
RenderSystem.sort = 'layer'

local ww, wh = love.graphics.getDimensions()
local camera = Game.camera
function RenderSystem.update(e)
    love.graphics.push()
    if not e.onCamera then
        love.graphics.translate(ww/2 - camera.x, wh/2 - camera .y)
    end

    if e.trail then
        love.graphics.draw(e.trail)
    end
    love.graphics.setColor(e.color)

    if e.rotation then
        love.graphics.push()
        love.graphics.translate(e.x, e.y)
        love.graphics.rotate(math.rad(e.rotation))
            love.graphics.rectangle(
                'fill', -e.width/2, -e.height/2, e.width, e.height, 4 , 4
            )
        love.graphics.pop()
    else
        love.graphics.rectangle('fill', e.x - e.width/2, e.y - e.height/2, e.width, e.height)
    end

    if e.showDirection then
        love.graphics.setColor(0.5, 0.5, 0.5)
        love.graphics.circle('fill', e.x + 8*e.direction, e.y, 4)
    end

    if e.font and e.text then
        local old = love.graphics.getFont()

        local font = love.graphics.newFont(e.font.file, e.font.size)
        local w = font:getWidth(e.text)
        local h = font:getHeight()

        love.graphics.setColor(e.font.color)
        love.graphics.setFont(font)
        love.graphics.print(e.text, e.x - w/2, e.y - h/2)
        love.graphics.setFont(old)
    end
    love.graphics.pop()
end

local HudSystem = secsi.system{'isHud'}
HudSystem.group = 'draw'

local function printCentered(text, x, y)
    local font = love.graphics.getFont()
    local w = font:getWidth(text)
    local h = font:getHeight()
    love.graphics.print(text, x - w/2, y - h/2)
end

function HudSystem.update(e)
    local oldFont = love.graphics.getFont()
    love.graphics.setColor(e.fontColor)
    if e.showScore then
        love.graphics.print('Score: '..Game.score, 25, 25)
    end

    if e.showHighscore then
        love.graphics.print('High Score: '..Game.highscore, 100, 25)
    end

    if e.debug then
        love.graphics.print('Entities: '..#secsi.get{}, 25, 50)
        love.graphics.print('FPS: '..love.timer.getFPS(), 25, 75)
    end

    if e.showGameover then
        local fh = e.bigFont:getHeight()
        love.graphics.setFont(e.bigFont)
        printCentered('Game over!', ww/2, wh/3)
        printCentered('Score: '..Game.score, ww/2, wh/3 + fh*1.5)
        printCentered('highest: '..Game.highscore, ww/2, wh/3 + fh*2.5)
    end
    love.graphics.setFont(oldFont)
end