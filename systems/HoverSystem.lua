local secsi = require 'secsi'

local HoverSystem = secsi.system{'hover'}

local t = 0.5
function HoverSystem.update(e)
    local mx, my = love.mouse.getPosition()

    if mx < e.x + e.width/2 and mx > e.x - e.width/2
    and my < e.y + e.height/2 and my > e.y - e.height/2 then
        e.tweens.x = {e.hoverTo.x, t, 'quadOut'}
        e.tweens.y = {e.hoverTo.y, t, 'quadOut'}
    else
        e.tweens.x = {e.hoverOff.x, t/5, 'linear'}
        e.tweens.y = {e.hoverOff.y, t/5, 'linear'}
    end
end