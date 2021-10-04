local secsi = require 'secsi'

local Arm = secsi.entity{
    image = love.graphics.newImage('assets/armcoat.png'),
    render = true,
    layer = 10,
    arm = true,
}

local ww, wh = love.graphics.getDimensions()
function Arm:init()
    self.height = self.image:getHeight()
    self.width = self.image:getWidth()*(self.height/self.image:getHeight())
    self.x = ww/2
    self.y = wh/2
end

return Arm