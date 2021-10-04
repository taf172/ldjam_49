local secsi = require 'secsi'

local Clipboard = secsi.entity{
    image = love.graphics.newImage('assets/clipboard.png'),
    render = true,
    layer = 3,
    isClipboard = true
}

local ww, wh = love.graphics.getDimensions()
function Clipboard:init(x, y)
    self.height = 325
    self.width = self.image:getWidth()*(self.height/self.image:getHeight())
    self.x = 25 + self.width/2
    self.y = wh + self.height/8

    self.textColor = {0.1, 0.1, 0.1}
    self.textWidth =  self.width*0.76
    self.textY = self.height*0.35
    self.textX = self.width*1/8

    self.hover = true
    self.hoverTo = { x = self.x, y = wh - self.height/2}
    self.hoverOff= { x = self.x, y = self.y}
    self.tweens = {}

end

return Clipboard