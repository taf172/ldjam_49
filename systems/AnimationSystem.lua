local secsi = require 'secsi'

local AnimationSystem = secsi.system{
    any = {'float'}
}

local ww, wh = love.graphics.getDimensions()
function AnimationSystem.update(e)
    if e.float then
        e.tweens.y = {wh + e.width, 1, 'linear'}
    end

    if e.fade then
        e.tweens.alpha = {0, 1, 'linear'}
    end

end