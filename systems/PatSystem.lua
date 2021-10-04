local secsi = require 'secsi'

local PatSystem = secsi.system{'pattable', 'bellyPatCount'}

local bapImage = love.graphics.newImage('assets/bap.png')
local bapSound = love.audio.newSource('assets/sounds/bap.wav', 'static')
local mh = false
function PatSystem.update(e)
    local mx, my = love.mouse.getPosition()

    if mx > e.x - e.width/6 and mx < e.x + e.width/2
    and my > e.y - e.height/6 and my < e.y + e.height/2 
    and love.mouse.isDown(1) and not mh then
        local bap = {
            image = bapImage,
            width = 64, height = 64,
            layer = 9,
            x = mx, y = my,
            render = true,
            lifetime = 0.125, timer = 0

        }
        secsi.add(bap)
        bapSound:play()
        e.bellyPatCount = e.bellyPatCount + 1

    end

    mh = love.mouse.isDown(1)
end