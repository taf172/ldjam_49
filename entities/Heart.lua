local secsi = require 'secsi'

local Heart = secsi.entity{
    image = love.graphics.newImage('assets/heart.png'),
    render = true,
    layer = 3,
}

local ww, wh = love.graphics.getDimensions()
function Heart:init(x, y)
    self.height = 64
    self.width = self.image:getWidth()*(self.height/self.image:getHeight())

    self.float = true
    self.fade = true
    self.alpha = 1
    self.tweens = {}
    self.sway = 32

    self.lifetime = 3
    self.timer = 0
end

return Heart