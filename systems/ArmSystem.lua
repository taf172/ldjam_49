local secsi = require 'secsi'

local ArmSystem = secsi.system{'arm'}

function ArmSystem.update(e)
    local mx, my = love.mouse.getPosition()

    e.x = e.x + (mx - e.x)*0.125
    e.y = e.y + (my + e.height/2 - e.y)*0.125

    --[[
    if mx > love.graphics.getWidth()/2 then
        e.flip = true
    else
        e.flip = false
    end
    --]]
end