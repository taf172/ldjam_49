local secsi = require 'secsi'

local Heart = secsi.entity{
    image = love.graphics.newImage('assets/heart.png'),
    render = true,
    layer = 3,
}

local ww, wh = love.graphics.getDimensions()
function Heart:init()
    self.height = 64
    self.width = self.image:getWidth()*(self.height/self.image:getHeight())
    self.x = ww/2
    self.y = wh/2
    self.float = true
    self.fade = true
    self.alpha = 1
    self.tweens = {}
end

return Heart