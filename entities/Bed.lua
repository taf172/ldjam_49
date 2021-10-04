local secsi = require 'secsi'

local Bed = secsi.entity{
    image = love.graphics.newImage('assets/bed.png'),
    render = true,
    layer = -1
}

local ww, wh = love.graphics.getDimensions()
function Bed:init()
    self.height = wh - 50
    self.width = self.image:getWidth()*(self.height/self.image:getHeight())
    self.x = ww/2
    self.y = wh/2
    self.tweens = {}
end

return Bed