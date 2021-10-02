local secsi = require 'secsi'

local ButtonSystem = secsi.system{
    'pressable',
    'x', 'y', 'width', 'height',
}

local mouseHeld = false
function ButtonSystem.update(e)
    local mx, my = love.mouse.getPosition()
    local md = love.mouse.isDown(1)
    if mx > e.x - e.width/2 and mx < e.x + e.width/2
    and my > e.y - e.height/2 and my < e.y + e.height/2 then
        if md and not mouseHeld then
            e.pressed = true
        end
    end
    mouseHeld = md
end