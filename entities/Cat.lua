local secsi = require 'secsi'

local Cat = secsi.entity{
    image = love.graphics.newImage('assets/cat.png'),
    eyelids = love.graphics.newImage('assets/eyes.png'),
    render = true,
    layer = 2,
    isPatient = true
}

local ww, wh = love.graphics.getDimensions()
function Cat:init()
    self.height = wh - 100
    self.width = self.image:getWidth()*(self.height/self.image:getHeight())
    self.x = ww/2
    self.y = wh/2
    self.scale = 1/2
    self.eyesClosed = true
    self.tweens = {}
end

return Cat