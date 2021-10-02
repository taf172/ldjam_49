local secsi = require 'secsi'

local RenderSystem = secsi.system{ 'x', 'y', 'image', 'layer', 'render'}
RenderSystem.group = 'draw'
RenderSystem.sort = 'layer'

local ww, wh = love.graphics.getDimensions()

local box = false
function RenderSystem.update(e)
    
    if box then
        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle(
            'line', 
            e.x - e.width/2, e.y - e.height/2, e.width, e.height
        )
    end
    
    local rotation = 0
    if e.rotation then rotation = e.rotation end
    
    love.graphics.setColor(1, 1, 1)
    if e.alpha then
        love.graphics.setColor(1, 1, 1, e.alpha)
    end
    local sw = 1
    local sh = 1
    if e.image == 'rect' then
        love.graphics.rectangle(
            'fill', e.x - e.width/2, e.y-e.height/2, e.width, e.height
        )
    else
        local iw = e.image:getWidth()
        local ih = e.image:getHeight()
        sw = e.width/iw
        sh = e.height/ih
        if e.flip then
            sw = -sw
        end
        love.graphics.draw(
            e.image,
            e.x, e.y, rotation,
            sw, sh,
            iw/2, ih/2
        )
    end
    --love.graphics.circle('fill', e.x, e.y, 5)

    if e.eyelids then
        love.graphics.draw(e.eyelids, e.x - e.width/2, e.y - e.height/2, rotation, sw, sh)
    end

    if e.textCenter and e.text then
        local font = love.graphics.getFont()
        local w = font:getWidth(e.text)
        local h = font:getHeight()

        love.graphics.setColor(e.textColor)
        love.graphics.print(e.text, e.x - w/2, e.y - h/2)
    elseif e.text then
        love.graphics.setColor(e.textColor)
        local x = e.x - e.width/2
        local y = e.y - e.height/2
        love.graphics.printf(
            e.text, x + e.textX, y + e.textY, e.textWidth, 'left', rotation
        )
    end
end
