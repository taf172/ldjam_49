local secsi = require 'secsi'

local HoverSystem = secsi.system{'hover'}

local function isHovering(e)
    local mx, my = love.mouse.getPosition()
    return mx < e.x + e.width/2 and mx > e.x - e.width/2
    and my < e.y + e.height/2 and my > e.y - e.height/2
end

local t = 0.5
function HoverSystem.update(e)
    local mx, my = love.mouse.getPosition()

    if isHovering(e) and not e.hoveringTo then
        e.tweens.x = {e.hoverTo.x, t, 'quadOut'}
        e.tweens.y = {e.hoverTo.y, t, 'quadOut'}
        if e.hoverToSound then e.hoverToSound:play() end
        e.hoveringTo = true
    end

    if not isHovering(e) and e.hoveringTo then
        e.tweens.x = {e.hoverOff.x, t, 'linear'}
        e.tweens.y = {e.hoverOff.y, t, 'linear'}
        if e.hoverOffSound then e.hoverOffSound:play() end
        e.hoveringTo = false
    end
end